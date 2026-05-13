import 'dart:math';

import 'package:flutter/material.dart';

import '../physics/bubble.dart';

/// Zeichnet den Wasserstand, die Wellen und die Blasen innerhalb eines
/// bereits geclipt-en Canvas (ClipOval wird im Widget darum gelegt).
class WaterPainter extends CustomPainter {
  final double progress;
  final double wavePhase;
  final double tiltAngle;
  final List<Bubble> bubbles;

  const WaterPainter({
    required this.progress,
    required this.wavePhase,
    required this.tiltAngle,
    required this.bubbles,
  });

  // ── Hilfsmethode: Y-Position der Wasseroberfläche an Stelle x ─────────────

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
      }) =>
      _surfaceYWithProgress(x, size, progress,
          phaseOffset: phaseOffset,
          freqScale: freqScale,
          extraRise: extraRise);

  // ── Wellenpfad ────────────────────────────────────────────────────────────

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

    // Clip auf Kreis
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
    );

    final rect        = Rect.fromLTWH(0, 0, size.width, size.height);
    final goalReached = progress >= 1.0;

    if (goalReached) {
      // Volles Wasser: einfarbiger Verlauf
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
      // Hinterwelle (leicht versetzt, hellblau)
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

      // Vorderwelle (kräftiger blau)
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

    // Blasen
    for (final b in bubbles) {
      final px       = b.x * size.width;
      final surfaceY = _surfaceY(px, size);
      final t        = Curves.easeOut.transform(b.life);
      final bubbleY  = size.height - t * (size.height - surfaceY);
      final dist     = (bubbleY - surfaceY).clamp(0.0, double.infinity);
      final opacity  = (dist / (b.size * 6)).clamp(0.0, 1.0);
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
  bool shouldRepaint(covariant WaterPainter o) =>
      o.progress  != progress  ||
          o.wavePhase != wavePhase ||
          o.tiltAngle != tiltAngle ||
          o.bubbles   != bubbles;
}