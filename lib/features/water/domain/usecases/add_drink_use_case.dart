import '../repositories/water_repository.dart';

/// Kapselt die Geschäftslogik für das Hinzufügen eines Drinks.
/// Kann später Validierung, Min/Max-Checks oder Events enthalten.
class AddDrinkUseCase {
  final WaterRepository _repository;

  const AddDrinkUseCase(this._repository);

  Future<void> call(double amount, {required DateTime date}) async {
    if (amount <= 0) {
      throw ArgumentError('Menge muss größer als 0 sein.');
    }
    await _repository.addDrink(amount, date: date);
  }
}
