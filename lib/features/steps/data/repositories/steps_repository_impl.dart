import '../../domain/entities/daily_step_stats.dart';
import '../../domain/repositories/steps_repository.dart';

import '../datasources/local/step_local_datasource.dart';
import '../datasources/remote/health_connect_steps_datasource.dart';

class StepsRepositoryImpl implements StepsRepository {
  final StepLocalDataSource local;
  final HealthConnectStepsDataSource remote;

  StepsRepositoryImpl({
    required this.local,
    required this.remote,
  });

  @override
  Future<DailyStepStats> getDailySteps(DateTime day) async {
    final cached = await local.getSteps(day);

    if (cached != null) {
      return cached;
    }

    try {
      await syncDailySteps(day);
    } catch (e) {
      // fallback verhindern infinite loading
      if (cached != null) return cached;
      rethrow;
    }

    final afterSync = await local.getSteps(day);

    if (afterSync != null) return afterSync;

    // 🔥 HARD FALLBACK → verhindert Loader Freeze
    return DailyStepStats(
      day: DateTime(day.year, day.month, day.day),
      steps: 0,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Stream<DailyStepStats?> watchDailySteps(DateTime day) {
    return local.watchSteps(day);
  }

  @override
  Future<void> syncDailySteps(DateTime day) async {
    final steps = await remote.getStepsForDay(day);

    await local.saveSteps(
      day: DateTime(day.year, day.month, day.day),
      steps: steps,
    );
  }
}