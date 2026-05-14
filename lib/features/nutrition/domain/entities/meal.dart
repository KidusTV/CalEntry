import 'package:calentry/features/nutrition/domain/entities/food.dart';

enum MealType {
  breakfast,
  lunch,
  dinner,
  snacks,
}

extension MealTypeX on MealType {
  String get title {
    return switch (this) {
      MealType.breakfast => 'Frühstück',
      MealType.lunch => 'Mittagessen',
      MealType.dinner => 'Abendessen',
      MealType.snacks => 'Snacks',
    };
  }
}

class Meal {
  final String name;
  final String icon;
  final List<FoodEntryEntity> foods;
  final List<int> stats;

  const Meal({
    required this.name,
    required this.foods,
    required this.icon,
    required this.stats,
  });
}

