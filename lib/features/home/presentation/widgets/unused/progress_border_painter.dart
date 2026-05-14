

import 'dart:math' as math;

import 'package:flutter/material.dart';

class _ProgressBorderPainter extends CustomPainter {
  final double progress;
  final bool isActive;

  _ProgressBorderPainter({
    required this.progress,
    required this.isActive,
  });

  @override
  void paint(Canvas canvas, Size size) {

    // PROGRESS BORDER (arc effect)
    final progressPaint = Paint()
      ..color = isActive ? Color(0xFFFFB36B): Color(0xFFFF7D54)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isActive ? 1.6 : 1.2
      ..strokeCap = StrokeCap.round;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(999),
    );

    // Startpunkt verschieben (Rotation des Pfads)
    final path = Path()
      ..addRRect(rrect)
      ..transform(Matrix4.rotationZ(-math.pi / 2).storage);

    final metrics = path.computeMetrics().first;

    final totalLength = metrics.length;
    final startOffset = totalLength * 0.75;
    final drawLength = totalLength * progress;

    final endOffset = startOffset + drawLength;

    Path extractPath;

    if (endOffset <= totalLength) {
      extractPath = metrics.extractPath(
        startOffset,
        endOffset,
      );
    } else {
      extractPath = Path()
        ..addPath(
          metrics.extractPath(startOffset, totalLength),
          Offset.zero,
        )
        ..addPath(
          metrics.extractPath(0, endOffset - totalLength),
          Offset.zero,
        );
    }

    canvas.drawPath(extractPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _ProgressBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isActive != isActive;
  }
}