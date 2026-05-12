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