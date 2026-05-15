import 'dart:ui';
import 'package:flutter/material.dart';
import '../painters/goal_ring_painter.dart';
import '../painters/water_painter.dart';
import '../physics/bubble.dart';

class WaterCircle extends StatelessWidget {
  final double displayedProgress;
  final double wavePhase;
  final double tiltAngle;
  final double rollAngle;       
  final double ringOpacity;     
  final List<Bubble> bubbles;
  final Widget child; 

  const WaterCircle({
    super.key,
    required this.displayedProgress,
    required this.wavePhase,
    required this.tiltAngle,
    required this.rollAngle,
    required this.ringOpacity,
    required this.bubbles,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, 
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Hintergrund-Glas
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

          // Wasser-Effekt
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

          // Ziel-Ring (Glow)
          if (ringOpacity > 0.0)
            CustomPaint(
              size: const Size(120, 120),
              painter: GoalRingPainter(opacity: ringOpacity),
            ),

          // Zentraler Inhalt
          // ClipOval maskiert alles exakt auf Kreisform.
          // OverflowBox erlaubt dem Picker, horizontal breiter zu sein,
          // damit die Zahlen nicht am Rand "gequetscht" werden.
          ClipOval(
            child: SizedBox(
              width: 120,
              height: 120,
              child: OverflowBox(
                maxWidth: 200, // Picker darf breiter sein
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}