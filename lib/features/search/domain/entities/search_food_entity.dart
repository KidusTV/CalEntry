class SearchFoodEntity {
  final String id;
  final String title;
  final String brand;
  final double calories;
  final double protein;
  final String? imageUrl;

  const SearchFoodEntity({
    required this.id,
    required this.title,
    required this.brand,
    required this.calories,
    required this.protein,
    this.imageUrl,
  });
}