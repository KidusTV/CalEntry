import 'meal_type.dart';

class FoodEntryEntity {
  final String id;
  final String title;
  final String? imageUrl;
  final double calories;
  final double protein;
  final double fat;
  final double sugar;
  final MealType mealType;
  final DateTime createdAt;

  const FoodEntryEntity({
    required this.id,
    required this.title,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.sugar,
    required this.mealType,
    required this.createdAt,
    this.imageUrl,
  });
}