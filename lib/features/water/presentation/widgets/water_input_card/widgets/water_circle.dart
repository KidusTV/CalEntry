import 'dart:ui';

import 'package:flutter/material.dart';

import '../painters/goal_ring_painter.dart';
import '../painters/water_painter.dart';
import '../physics/bubble.dart';

/// Der animierte Wasserkreis mit Glasshintergrund, Wellen, Blasen,
/// Ziel-Ring und zentriertem Label.
///
/// Rotiert von außen per [rollAngle] (wird von [WaterInputCard] übergeben).
class WaterCircle extends StatelessWidget {
  final double displayedProgress;
  final double wavePhase;
  final double tiltAngle;
  final double rollAngle;       // Gesamtrotation des Kreises
  final double ringOpacity;     // 0..1 für GoalRingPainter
  final List<Bubble> bubbles;
  final int waterMl;            // Anzeigewert im Label

  const WaterCircle({
    super.key,
    required this.displayedProgress,
    required this.wavePhase,
    required this.tiltAngle,
    required this.rollAngle,
    required this.ringOpacity,
    required this.bubbles,
    required this.waterMl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.08),
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: Colors.white.withOpacity(0.05)),
              ),
            ),
          ),


          Transform.rotate(
            angle: rollAngle,
            child: CustomPaint(
              size: const Size(120, 120),
              painter: WaterPainter(
                progress:  displayedProgress,
                wavePhase: wavePhase,
                tiltAngle: tiltAngle,
                bubbles:   bubbles,
              ),
            ),
          ),


          if (ringOpacity > 0.0)
            CustomPaint(
              size: const Size(120, 120),
              painter: GoalRingPainter(opacity: ringOpacity),
            ),


          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.water_drop, color: Colors.white),
                const SizedBox(height: 4),
                Text(
                  '$waterMl ml',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}