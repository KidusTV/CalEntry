import '../entities/daily_step_stats.dart';
import '../repositories/steps_repository.dart';

class GetDailyStepsUseCase {
  final StepsRepository repository;

  GetDailyStepsUseCase(this.repository);

  Future<DailyStepStats> call(DateTime day) {
    return repository.getDailySteps(day);
  }
}