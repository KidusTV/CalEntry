import '../entities/daily_step_stats.dart';
import '../repositories/steps_repository.dart';

class GetDailyStepsUseCase {
  final StepsRepository repository;

  GetDailyStepsUseCase(this.repository);

  Future<DailyStepStats> call(DateTime day) async {
    // Da wir einen Stream-basierten Ansatz haben, nehmen wir den ersten Wert.
    // Das Repository kümmert sich im Hintergrund um den Sync.
    return repository.watchStepsForDate(day).first;
  }
}