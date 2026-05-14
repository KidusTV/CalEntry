import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../domain/entities/daily_water_stats.dart';
import '../../controllers/water_controller.dart';
import '../../providers/water_providers.dart';
import 'physics/bubble.dart';
import 'physics/water_physics.dart';
import 'widgets/circle_button.dart';
import 'widgets/water_circle.dart';

// ─────────────────────────────────────────────────────────────────────────────
// WaterInputCard
// ─────────────────────────────────────────────────────────────────────────────

/// Haupt-Widget des interaktiven Wasserkreises.
///
/// [dayOffset] steuert welcher Tag angezeigt wird:
///   0  = heute, -1 = gestern, +1 = morgen, usw.
///
/// Der Eltern-Widget (z. B. die PageView-Page) übergibt den Offset;
/// alle Lese- und Schreiboperationen verwenden ihn konsistent.
class WaterInputCard extends ConsumerStatefulWidget {
  final int dayOffset;

  const WaterInputCard({super.key, required this.dayOffset});

  @override
  ConsumerState<WaterInputCard> createState() => _WaterInputCardState();
}

class _WaterInputCardState extends ConsumerState<WaterInputCard> {
  // ── Physik-State ──────────────────────────────────────────────────────────
  double _displayedProgress = 0.0;
  double _progressVelocity  = 0.0;

  double _tiltAngle    = 0.0;
  double _tiltVelocity = 0.0;
  double _targetTilt   = 0.0;

  double _rollAngle        = 0.0;
  double _rollVelocity     = 0.0;
  double _targetRoll       = 0.0;
  double _visibleRollAngle = 0.0;

  double _wavePhase = 0.0;
  final List<Bubble> _bubbles = [];
  final _rng = Random();

  // ── Ziel-Flash ────────────────────────────────────────────────────────────
  double _goalFlashT     = 0.0;
  bool   _wasGoalReached = false;

  double get _ringOpacity {
    if (_goalFlashT <= 0.0) return 0.0;
    if (_goalFlashT < 0.15) return _goalFlashT / 0.15;
    if (_goalFlashT < 0.70) return 1.0;
    return 1.0 - ((_goalFlashT - 0.70) / 0.30);
  }

  // ── Ticker / Sensor ───────────────────────────────────────────────────────
  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;
  StreamSubscription<AccelerometerEvent>? _accelSub;

  // ── Zielwerte (aus DB-Stream) ─────────────────────────────────────────────
  double _targetProgress = 0.0;
  bool   _isFull         = false;
  int    _displayedMl    = 0;

  // ── Kurzreferenz auf den aktuellen dayOffset ──────────────────────────────
  // Über widget.dayOffset abrufbar, aber als lokale Kopie für den Sensor-
  // Callback (läuft außerhalb des build-Kontexts).
  int get _dayOffset => widget.dayOffset;

  @override
  void initState() {
    super.initState();

    _ticker = Ticker(_onFrame)..start();

    _accelSub = accelerometerEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen((event) {
      final normalizedX = (event.x / 9.81).clamp(-1.0, 1.0);
      _targetTilt = -normalizedX * kMaxTilt;
      _targetRoll = _isFull ? atan2(event.x, event.y) : 0.0;
    });
  }

  // ── didUpdateWidget: wenn der PageView auf einen anderen Tag wechselt ─────
  // Das Widget wird nicht neu erstellt — nur der dayOffset ändert sich.
  // Der Progress muss sofort auf den neuen Tageswert springen (kein Fade-over).
  @override
  void didUpdateWidget(WaterInputCard old) {
    super.didUpdateWidget(old);
    if (old.dayOffset != widget.dayOffset) {
      // Physik-State zurücksetzen, damit die Animation für den neuen Tag
      // sauber von 0 (oder dem tatsächlichen Wert) startet.
      _displayedProgress = 0.0;
      _progressVelocity  = 0.0;
      _displayedMl       = 0;
      _goalFlashT        = 0.0;
      _wasGoalReached    = false;
    }
  }

  // ── Frame-Loop ────────────────────────────────────────────────────────────

  void _onFrame(Duration elapsed) {
    final dt     = (elapsed - _lastElapsed).inMicroseconds / 1e6;
    _lastElapsed = elapsed;
    final safeDt = dt.clamp(0.0, 0.05);

    // Progress-Feder
    final progressResult = integrateProgress(
      target: _targetProgress,
      displayed: _displayedProgress,
      velocity: _progressVelocity,
      dt: safeDt,
    );

    _displayedProgress = progressResult.$1;
    _progressVelocity  = progressResult.$2;

    // Ziel-Flash
    final goalNow = _displayedProgress >= 0.999;
    if (goalNow && !_wasGoalReached) {
      _goalFlashT = 0.001;
    }
    _wasGoalReached = goalNow;
    _isFull         = goalNow;

    if (_goalFlashT > 0.0) {
      _goalFlashT += safeDt / kFlashDuration;
      if (_goalFlashT >= 1.0) _goalFlashT = 0.0;
    }

    // Neigung
    final tiltResult = integrateSpring(
      target: -_targetTilt,
      angle: _tiltAngle,
      velocity: _tiltVelocity,
      maxAngle: kMaxTilt,
      wrapAngle: false,
      dt: safeDt,
    );

    _tiltAngle    = tiltResult.$1;
    _tiltVelocity = tiltResult.$2;

    // Rotation
    final rollResult = integrateSpring(
      target: _targetRoll,
      angle: _rollAngle,
      velocity: _rollVelocity,
      maxAngle: kMaxRoll,
      wrapAngle: true,
      dt: safeDt,
    );

    _rollAngle    = rollResult.$1;
    _rollVelocity = rollResult.$2;

    // Sichtbare Rotation
    final rollTarget = _isFull ? _rollAngle : 0.0;
    var diff = rollTarget - _visibleRollAngle;
    while (diff >  pi) diff -= 2 * pi;
    while (diff < -pi) diff += 2 * pi;
    _visibleRollAngle += diff * min(1.0, safeDt * 6.0);

    // Welle
    final sloshing = _tiltVelocity.abs();
    _wavePhase = (_wavePhase + safeDt * (0.5 + sloshing * 0.2)) % (2 * pi);

    // Blasen
    for (int i = _bubbles.length - 1; i >= 0; i--) {
      _bubbles[i].life += safeDt * (0.28 + _rng.nextDouble() * 0.15);
      if (_bubbles[i].life >= 1.0) _bubbles.removeAt(i);
    }
    if (_rng.nextDouble() > 0.88 &&
        _displayedProgress > 0 &&
        _bubbles.length < 18) {
      _bubbles.add(Bubble(
        x:    _rng.nextDouble(),
        life: 0.0,
        size: _rng.nextDouble() * 3 + 2,
      ));
    }

    setState(() {});
  }

  // ── Stats aus Stream übernehmen ───────────────────────────────────────────

  void _applyStats(DailyWaterStats stats) {
    _targetProgress = stats.progress;
    _displayedMl    = stats.consumed.toInt();
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  Future<void> _addDrink(double amount) async {
    await ref.read(waterControllerProvider).addDrink(
      amount,
      dayOffset: _dayOffset,
    );
    HapticFeedback.lightImpact();
  }

  Future<void> _removeDrink(double amount) async {
    await ref.read(waterControllerProvider).removeDrink(
      amount,
      dayOffset: _dayOffset,
    );
    HapticFeedback.lightImpact();
  }

  // Future<void> _removeLast() async {
  //   await ref.read(waterControllerProvider).removeLastDrink(
  //     dayOffset: _dayOffset,
  //   );
  //   HapticFeedback.lightImpact();
  // }

  @override
  void dispose() {
    _ticker?.dispose();
    _accelSub?.cancel();
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // waterStatsProvider(dayOffset) → family StreamProvider
    // Jede Seite der PageView hat ihren eigenen Provider-Slot.
    final statsAsync = ref.watch(waterStatsProvider(_dayOffset));
    statsAsync.whenData(_applyStats);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleButton(
          icon:  Icons.remove,
          onTap: () => _removeDrink(250),
        ),

        GestureDetector(
          onTap: () {
            showWaterPicker(
              context,
              onChanged: (value) {
                // Wasser aktualisieren
              },
            );
          },
          child: WaterCircle(
            displayedProgress: _displayedProgress,
            wavePhase:         _wavePhase,
            tiltAngle:         _tiltAngle,
            rollAngle:         _visibleRollAngle,
            ringOpacity:       _ringOpacity,
            bubbles:           _bubbles,
            waterMl:           _displayedMl,
          ),
        ),

        CircleButton(
          icon:  Icons.add,
          onTap: () => _addDrink(250),
        ),
      ],
    );
  }

  Future<void> showWaterPicker(BuildContext context, {required ValueChanged<int> onChanged}) async {
    final controller = FixedExtentScrollController(initialItem: _displayedMl ~/ 50);

    int currentValue = _displayedMl;

    final selectedValue = await showGeneralDialog<int>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Water Picker",
      barrierColor: Colors.black54,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: SizedBox(
                height: 250,
                child: ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: 60,
                  perspective: 0.003,
                  diameterRatio: 1.4,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      currentValue = index * 50;
                    });

                    onChanged(currentValue);
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 61,
                    builder: (context, index) {
                      final value = index * 50;

                      final selected = value == currentValue;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context, value);
                        },
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 150),
                            style: TextStyle(
                              fontSize: selected ? 38 : 28,
                              fontWeight: selected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: selected
                                  ? Colors.white
                                  : Colors.white54,
                            ),
                            child: Text("$value"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (selectedValue != null) {
      final difference = selectedValue - _displayedMl;
      if (difference > 0) {
        _addDrink(difference.toDouble());

      } else if (difference < 0) {
        _removeDrink(difference.abs().toDouble());
      }
    }
  }
}