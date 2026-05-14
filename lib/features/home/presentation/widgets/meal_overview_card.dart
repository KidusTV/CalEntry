import 'dart:ui';

import 'package:flutter/material.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
                child: const Text(
                  '🍽',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ernährung',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      '$consumedCalories / $targetCalories kcal',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.6),
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// MEALS GRID
          Row(
            children: [
              Expanded(
                child: _MealItem(
                  emoji: '🍳',
                  title: 'Frühstück',
                  calories: breakfastCalories,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _MealItem(
                  emoji: '🍝',
                  title: 'Mittag',
                  calories: lunchCalories,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _MealItem(
                  emoji: '🥗',
                  title: 'Abend',
                  calories: dinnerCalories,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _MealItem(
                  emoji: '🍎',
                  title: 'Snacks',
                  calories: snackCalories,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MealItem extends StatelessWidget {
  final String emoji;
  final String title;
  final int calories;

  const _MealItem({
    required this.emoji,
    required this.title,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white60,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  calories == 0
                      ? 'Hinzufügen'
                      : '$calories kcal',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
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