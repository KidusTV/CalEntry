import '../repositories/water_repository.dart';

class RemoveEntryUseCase {
  final WaterRepository _repository;

  const RemoveEntryUseCase(this._repository);

  Future<void> call(String id) => _repository.removeEntry(id);
}