import '../repositories/steps_repository.dart';

class SyncStepsUseCase {
  final StepsRepository repository;

  SyncStepsUseCase(this.repository);

  Future<void> call(DateTime day) {
    return repository.syncSteps(day);
  }
}