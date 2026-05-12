// pubspec.yaml dependencies needed:
//   sensors_plus: ^4.0.0

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sensors_plus/sensors_plus.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Physics constants
// ─────────────────────────────────────────────────────────────────────────────

const double _kSpring  = 18.0; // spring stiffness — snappier tracking
const double _kDamping = 7.0;  // damping
const double _kMaxTilt = 0.38; // max water tilt ~22°
const double _kMaxRoll = pi;   // full 360° circle rotation allowed

// Duration of the green-ring flash animation in seconds
const double _kFlashDuration = 1.2;

// ─────────────────────────────────────────────────────────────────────────────
// WaterInputCard
// ─────────────────────────────────────────────────────────────────────────────

class WaterInputCard extends StatefulWidget {
  const WaterInputCard({super.key});

  @override
  State<WaterInputCard> createState() => _WaterInputCardState();
}

class _WaterInputCardState extends State<WaterInputCard> {
  // ── Water amount ───────────────────────────────────────────────────────────
  int waterMl = 250;
  double _displayedProgress  = 0.0;
  double _progressVelocity   = 0.0;
  double get targetProgress => (waterMl / 2000).clamp(0.0, 1.0);
  bool get isFull => _displayedProgress >= 0.999;

  // ── Goal flash ─────────────────────────────────────────────────────────────
  // _goalFlashT: 0.0 = not flashing, 0..1 = flash in progress
  double _goalFlashT = 0.0;
  bool _wasGoalReached = false; // debounce: only trigger once per crossing

  /// Opacity curve: quick fade-in, hold, gentle fade-out
  double get _ringOpacity {
    if (_goalFlashT <= 0.0) return 0.0;
    // Fade in over first 15 %, hold until 70 %, fade out over last 30 %
    if (_goalFlashT < 0.15) return _goalFlashT / 0.15;
    if (_goalFlashT < 0.70) return 1.0;
    return 1.0 - ((_goalFlashT - 0.70) / 0.30);
  }

  // ── Physics state — written by Ticker, read-only for painter ──────────────
  double _tiltAngle    = 0.0;
  double _tiltVelocity = 0.0;
  double _targetTilt   = 0.0;

  double _rollAngle    = 0.0;
  double _rollVelocity = 0.0;
  double _targetRoll   = 0.0;
  double _visibleRollAngle = 0.0;

  // ── Wave & bubbles ────────────────────────────────────────────────────────
  double _wavePhase = 0.0;
  final List<_Bubble> _bubbles = [];
  final _rng = Random();

  // ── Ticker ────────────────────────────────────────────────────────────────
  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;

  // ── Sensor subscription ───────────────────────────────────────────────────
  StreamSubscription<AccelerometerEvent>? _accelSub;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onFrame)..start();

    _accelSub = accelerometerEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen((event) {
      final normalizedX = (event.x / 9.81).clamp(-1.0, 1.0);
      _targetTilt = (-normalizedX * _kMaxTilt);
      _targetRoll = isFull ? atan2(event.x, event.y) : 0.0;
    });
  }

  void _onFrame(Duration elapsed) {
    final dt = (elapsed - _lastElapsed).inMicroseconds / 1e6;
    _lastElapsed = elapsed;
    final safeDt = dt.clamp(0.0, 0.05);

    // ── Progress spring-damper (replaces simple lerp) ─────────────────────
    // Critically-damped spring → uniform animation all the way to 0.
    const double kProgressSpeed   = 6.0;
    const double kProgressDamping = 2.0 * kProgressSpeed; // critically damped
    final dif = targetProgress - _displayedProgress;
    _progressVelocity += (kProgressSpeed * kProgressSpeed * dif
        - kProgressDamping * _progressVelocity) * safeDt;
    _displayedProgress += _progressVelocity * safeDt;
    if (dif.abs() < 0.0005 && _progressVelocity.abs() < 0.001) {
      _displayedProgress = targetProgress;
      _progressVelocity  = 0.0;
    }

    // ── Goal-reached flash trigger ────────────────────────────────────────
    final goalNow = _displayedProgress >= 0.999;
    if (goalNow && !_wasGoalReached) {
      // Crossing the threshold for the first time → start flash
      _goalFlashT = 0.001; // just above 0 so the curve picks it up
    }
    _wasGoalReached = goalNow;

    // Advance flash timer (0 → 1 over _kFlashDuration seconds)
    if (_goalFlashT > 0.0) {
      _goalFlashT += safeDt / _kFlashDuration;
      if (_goalFlashT >= 1.0) _goalFlashT = 0.0; // done
    }

    // ── Spring-damper for water tilt ──────────────────────────────────────
    _integrate(_targetTilt, safeDt,
        angle: _tiltAngle,
        velocity: _tiltVelocity,
        maxAngle: _kMaxTilt,
        wrapAngle: false,
        onUpdate: (a, v) { _tiltAngle = a; _tiltVelocity = v; });

    // ── Circle roll ───────────────────────────────────────────────────────
    _integrate(_targetRoll, safeDt,
        angle: _rollAngle,
        velocity: _rollVelocity,
        maxAngle: _kMaxRoll,
        wrapAngle: true,
        onUpdate: (a, v) { _rollAngle = a; _rollVelocity = v; });

    final rollDisplayTarget = isFull ? _rollAngle : 0.0;
    var diff = rollDisplayTarget - _visibleRollAngle;
    while (diff >  pi) diff -= 2 * pi;
    while (diff < -pi) diff += 2 * pi;
    _visibleRollAngle += diff * min(1.0, safeDt * 6.0);

    // ── Ambient wave phase ────────────────────────────────────────────────
    final sloshing = _tiltVelocity.abs();
    _wavePhase = (_wavePhase + safeDt * (0.5 + sloshing * 0.2)) % (2 * pi);

    // ── Bubbles ───────────────────────────────────────────────────────────
    for (int i = _bubbles.length - 1; i >= 0; i--) {
      _bubbles[i].life += safeDt * (0.28 + _rng.nextDouble() * 0.15);
      if (_bubbles[i].life >= 1.0) _bubbles.removeAt(i);
    }
    if (_rng.nextDouble() > 0.88 && _displayedProgress > 0 && _bubbles.length < 18) {
      _bubbles.add(_Bubble(
        x: _rng.nextDouble(),
        life: 0.0,
        size: _rng.nextDouble() * 3 + 2,
      ));
    }

    setState(() {});
  }

  void _integrate(
      double target,
      double dt, {
        required double angle,
        required double velocity,
        required double maxAngle,
        required bool wrapAngle,
        required void Function(double a, double v) onUpdate,
      }) {
    double error = angle - target;
    if (wrapAngle) {
      while (error >  pi) error -= 2 * pi;
      while (error < -pi) error += 2 * pi;
    }
    final acc = -_kSpring * error - _kDamping * velocity;
    velocity += acc * dt;
    angle += velocity * dt;
    if (!wrapAngle) angle = angle.clamp(-maxAngle, maxAngle);
    onUpdate(angle, velocity);
  }

  void addWater()    { waterMl += 250; }
  void removeWater() { waterMl = (waterMl - 250).clamp(0, 10000); }

  @override
  void dispose() {
    _ticker?.dispose();
    _accelSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringOpacity = _ringOpacity;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _CircleButton(icon: Icons.remove, onTap: removeWater),

        Transform.rotate(
          angle: _visibleRollAngle,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                // ── Water circle ─────────────────────────────────────────
                CustomPaint(
                  size: const Size(120, 120),
                  painter: _WaterPainter(
                    progress:  _displayedProgress,
                    wavePhase: _wavePhase,
                    tiltAngle: _tiltAngle,
                    bubbles:   _bubbles,
                  ),
                ),

                // ── Goal-reached green ring overlay ──────────────────────
                if (ringOpacity > 0.0)
                  CustomPaint(
                    size: const Size(120, 120),
                    painter: _GoalRingPainter(opacity: ringOpacity),
                  ),

                // ── Label ────────────────────────────────────────────────
                Center(
                  child: Transform.rotate(
                    angle: -_visibleRollAngle,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.water_drop, color: Colors.white),
                        const SizedBox(height: 4),
                        Text(
                          "$waterMl ml",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        _CircleButton(icon: Icons.add, onTap: addWater),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Goal ring painter
// Draws a glowing green stroke around the circle that fades in and out.
// ─────────────────────────────────────────────────────────────────────────────

class _GoalRingPainter extends CustomPainter {
  final double opacity; // 0..1

  const _GoalRingPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer soft glow
    canvas.drawCircle(
      center,
      radius + 1,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..color = const Color(0xFF4CAF50).withOpacity(opacity * 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Crisp inner ring
    canvas.drawCircle(
      center,
      radius - 1,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = const Color(0xFF66BB6A).withOpacity(opacity),
    );
  }

  @override
  bool shouldRepaint(covariant _GoalRingPainter old) => old.opacity != opacity;
}

// ─────────────────────────────────────────────────────────────────────────────
// Circle button
// ─────────────────────────────────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter
// ─────────────────────────────────────────────────────────────────────────────

class _WaterPainter extends CustomPainter {
  final double progress;
  final double wavePhase;
  final double tiltAngle;
  final List<_Bubble> bubbles;

  const _WaterPainter({
    required this.progress,
    required this.wavePhase,
    required this.tiltAngle,
    required this.bubbles,
  });

  double _surfaceYWithProgress(
      double x,
      Size size,
      double p, {
        double phaseOffset = 0,
        double freqScale   = 1.0,
        double extraRise   = 0,
      }) {
    final midY    = size.height * (1 - p);
    final centerX = size.width / 2;
    // fadeOut: flatten waves near full; fadeIn: flatten waves near empty
    final fadeOut  = 1.0 - ((p - 0.90) / 0.10).clamp(0.0, 1.0);
    final fadeIn   = (p / 0.10).clamp(0.0, 1.0);
    final waveMult = fadeOut * fadeIn;
    final tilt    = tan(tiltAngle) * (x - centerX) * waveMult;
    final ripple  = sin((x * 0.05 * freqScale) + wavePhase + phaseOffset)
        * 8 * waveMult;
    return midY + tilt + ripple - extraRise;
  }

  double _surfaceY(
      double x,
      Size size, {
        double phaseOffset = 0,
        double freqScale   = 1.0,
        double extraRise   = 0,
      }) => _surfaceYWithProgress(x, size, progress,
      phaseOffset: phaseOffset, freqScale: freqScale, extraRise: extraRise);

  Path _wavePath(Size size, double Function(double) fn) {
    final path = Path();
    for (double x = 0; x <= size.width; x++) {
      final y = fn(x);
      x == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    return path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
    );
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final goalReached = progress >= 1.0;

    if (goalReached) {
      canvas.drawRect(
        rect,
        Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFF6EC6FF), Color(0xFF1E88E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(rect),
      );
    } else {
      final bgProgress = progress.clamp(0.0, 0.875);

      canvas.drawPath(
        _wavePath(size, (x) => _surfaceYWithProgress(x, size, bgProgress,
            phaseOffset: pi * 0.6, freqScale: 0.85, extraRise: 6)),
        Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFFAEDFF7), Color(0xFF64B5F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(rect),
      );

      canvas.drawPath(
        _wavePath(size, (x) => _surfaceY(x, size)),
        Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFF6EC6FF), Color(0xFF1E88E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(rect),
      );
    }

    for (final b in bubbles) {
      final px = b.x * size.width;
      final surfaceY = _surfaceY(px, size);

      final t       = Curves.easeOut.transform(b.life);
      final bubbleY = size.height - t * (size.height - surfaceY);
      final dist    = (bubbleY - surfaceY).clamp(0.0, double.infinity);
      final opacity = (dist / (b.size * 6)).clamp(0.0, 1.0);
      if (opacity <= 0.0) continue;

      canvas.drawCircle(
        Offset(px, bubbleY),
        b.size,
        Paint()
          ..color = Colors.white.withOpacity(0.30 * opacity)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WaterPainter o) =>
      o.progress   != progress  ||
          o.wavePhase  != wavePhase ||
          o.tiltAngle  != tiltAngle ||
          o.bubbles    != bubbles;
}

// ─────────────────────────────────────────────────────────────────────────────
// Bubble
// ─────────────────────────────────────────────────────────────────────────────

class _Bubble {
  final double x;
  double life;
  final double size;
  _Bubble({required this.x, required this.life, required this.size});
}