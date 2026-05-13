import '../repositories/water_repository.dart';

/// Löscht den neuesten Eintrag des heutigen Tages.
/// Macht nichts wenn keine Einträge vorhanden sind.
class RemoveLastDrinkUseCase {
  final WaterRepository _repository;

  const RemoveLastDrinkUseCase(this._repository);

  Future<void> call({required DateTime date}) => _repository.removeLastDrink(date: date);
}