import 'dart:ui';

import 'package:calentry/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/theme/app_text_theme.dart';
import '../../domain/entities/dummies.dart';
import '../../domain/entities/meal.dart';

class MealOverviewCard extends StatelessWidget {
  final int consumedCalories;
  final int targetCalories;

  final int breakfastCalories;
  final int lunchCalories;
  final int dinnerCalories;
  final int snackCalories;

  final VoidCallback? onTap;

  const MealOverviewCard({
    super.key,
    required this.consumedCalories,
    required this.targetCalories,
    required this.breakfastCalories,
    required this.lunchCalories,
    required this.dinnerCalories,
    required this.snackCalories,
    this.onTap,
  });

  double get progress {
    if (targetCalories <= 0) return 0;
    return (consumedCalories / targetCalories).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: AppSpacing.md,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Text(
              '🍽',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),

          Expanded(
            child: Text(
              'Ernährung',
              style: theme.textTheme.titleLarge,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
