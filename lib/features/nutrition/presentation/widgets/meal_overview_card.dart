import 'package:calentry/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_radius.dart';

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
    final remaining = targetCalories - consumedCalories;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        spacing: 14,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Titel & Prozent
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: AppSpacing.md,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  Icons.flatware,
                  size: 22,
                ),
              ),
              Text(
                "Ernährung",
                style: theme.textTheme.titleLarge,
              )
            ],
          ),

          // Kalorien Anzeige (Hauptwert)
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "$consumedCalories",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "/ $targetCalories kcal",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.08),
              valueColor: AlwaysStoppedAnimation(
                const Color(0xFFFFB74D).withOpacity(0.9), // Warmes Orange für Food
              ),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MealMiniStat(label: "Früh", value: breakfastCalories),
              _MealMiniStat(label: "Mittag", value: lunchCalories),
              _MealMiniStat(label: "Abend", value: dinnerCalories),
              _MealMiniStat(label: "Snacks", value: snackCalories),
            ],
          ),
        ],
      ),
    );
  }
}

class _MealMiniStat extends StatelessWidget {
  final String label;
  final int value;

  const _MealMiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.4),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "$value",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}