import '../repositories/water_repository.dart';

class SetGoalUseCase {
  final WaterRepository _repository;

  const SetGoalUseCase(this._repository);

  Future<void> call(double amount, {String unit = 'ml'}) async {
    if (amount <= 0) {
      throw ArgumentError('Ziel muss größer als 0 sein.');
    }
    await _repository.setGoal(amount, unit: unit);
  }
}