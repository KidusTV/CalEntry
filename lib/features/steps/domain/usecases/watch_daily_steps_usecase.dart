import '../entities/daily_step_stats.dart';
import '../repositories/steps_repository.dart';

class WatchDailyStepsUseCase {
  final StepsRepository repository;

  WatchDailyStepsUseCase(this.repository);

  Stream<DailyStepStats?> call(DateTime day) {
    return repository.watchDailySteps(day);
  }
}