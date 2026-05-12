import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/meal_type.dart';
import 'nutrition_meal_card.dart';

class NutritionSection extends StatelessWidget {
  final int dayOffset;

  const NutritionSection({
    super.key,
    required this.dayOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Column(
        children: MealType.values.map((meal) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: NutritionMealCard(
              mealType: meal,
              dayOffset: dayOffset,
            ),
          );
        }).toList(),
      ),
    );
  }
}