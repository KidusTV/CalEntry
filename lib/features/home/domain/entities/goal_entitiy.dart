import 'package:flutter/material.dart';

enum GoalUnit {
  kcal,
  grams,
  milliliter,
  percent,
}

class GoalEntity {
  final String id;

  final String title;
  final String shortLabel;

  final double current;
  final double target;

  final String unit;

  final IconData icon;

  const GoalEntity({
    required this.id,
    required this.title,
    required this.shortLabel,
    required this.current,
    required this.target,
    required this.unit,
    required this.icon,
  });

  double get progress {
    return (current / target).clamp(0, 1);
  }

  double get remaining {
    return target - current;
  }
}