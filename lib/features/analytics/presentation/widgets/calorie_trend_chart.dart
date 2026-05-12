import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_card.dart';

class CalorieTrendChart extends StatelessWidget {
  const CalorieTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kalorientrend',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 220,
              child: CustomPaint(
                painter: _TrendPainter(),
                size: const Size(double.infinity, 220),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = <Offset>[];

    for (int i = 0; i < 7; i++) {
      final x = (size.width / 6) * i;
      final y = 80 + sin(i * 0.8) * 50;

      points.add(Offset(x, y));
    }

    final path = Path();

    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      final controlX = (p1.dx + p2.dx) / 2;

      path.cubicTo(
        controlX,
        p1.dy,
        controlX,
        p2.dy,
        p2.dx,
        p2.dy,
      );
    }

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFFFB36B),
          Color(0xFFFF7D54),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, strokePaint);

    final fillPath = Path.from(path)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0x33FF8A5B),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    for (final p in points) {
      final dotPaint = Paint()
        ..color = const Color(0xFFFFA56B)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(p, 4.5, dotPaint);

      final glowPaint = Paint()
        ..color = const Color(0x44FF8A5B)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawCircle(p, 10, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}