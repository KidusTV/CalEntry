import 'dart:math';

import 'package:flutter/material.dart';

import 'animated_counter.dart';

class RadialGoalProgress extends StatelessWidget {
  final double current;
  final double target;

  const RadialGoalProgress({
    super.key,
    this.current = 1834,
    this.target = 2400,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (current / target).clamp(0, 1);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, child) {
        return CustomPaint(
          painter: _GoalPainter(progress: animatedProgress),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedCounter(
                  value: current,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'von ${target.toInt()} kcal',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GoalPainter extends CustomPainter {
  final double progress;

  _GoalPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.4;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..color = Colors.white12;

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 28
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16)
      ..color = const Color(0x55FF8A5B);

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: const [
          Color(0xFFFFB36B),
          Color(0xFFFF7B54),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    const startAngle = pi * 0.72;
    const sweepBackground = pi * 1.56;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    canvas.drawArc(
      rect,
      startAngle,
      sweepBackground * progress,
      false,
      glowPaint,
    );

    canvas.drawArc(
      rect,
      startAngle,
      sweepBackground,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      rect,
      startAngle,
      sweepBackground * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GoalPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}