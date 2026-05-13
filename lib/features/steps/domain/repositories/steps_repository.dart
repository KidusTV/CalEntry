import '../entities/daily_step_stats.dart';

abstract class StepsRepository {
  Future<DailyStepStats> getDailySteps(DateTime day);

  Stream<DailyStepStats?> watchDailySteps(DateTime day);

  Future<void> syncDailySteps(DateTime day);
}