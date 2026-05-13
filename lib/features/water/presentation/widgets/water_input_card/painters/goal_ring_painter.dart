import 'package:flutter/material.dart';

/// Zeichnet einen grün leuchtenden Ring rund um den Kreis,
/// wenn das Tagesziel erreicht wurde. Opacity läuft per Flash-Kurve.
class GoalRingPainter extends CustomPainter {
  final double opacity; // 0..1

  const GoalRingPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Weicher äußerer Glow
    canvas.drawCircle(
      center,
      radius + 1,
      Paint()
        ..style      = PaintingStyle.stroke
        ..strokeWidth = 10
        ..color      = const Color(0xFF4CAF50).withOpacity(opacity * 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Knackiger innerer Ring
    canvas.drawCircle(
      center,
      radius - 1,
      Paint()
        ..style      = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color      = const Color(0xFF66BB6A).withOpacity(opacity),
    );
  }

  @override
  bool shouldRepaint(covariant GoalRingPainter old) => old.opacity != opacity;
}