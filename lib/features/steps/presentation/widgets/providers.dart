import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';

import '../../../water/presentation/providers/water_providers.dart';
import '../../data/datasources/local/step_local_datasource.dart';
import '../../data/datasources/remote/health_connect_steps_datasource.dart';
import '../../data/repositories/steps_repository_impl.dart';
import '../../domain/entities/daily_step_stats.dart';
import '../../domain/repositories/steps_repository.dart';

final healthProvider = Provider<Health>((ref) {
  return Health();
});

final healthConnectDataSourceProvider =
Provider<HealthConnectStepsDataSource>((ref) {
  return HealthConnectStepsDataSource(
    ref.read(healthProvider),
  );
});

final stepLocalDataSourceProvider = Provider<StepLocalDataSource>((ref) {
  return StepLocalDataSource(
    ref.read(appDatabaseProvider),
  );
});

final stepsRepositoryProvider = Provider<StepsRepository>((ref) {
  return StepsRepositoryImpl(
    local: ref.watch(stepLocalDataSourceProvider),  // watch statt read
    remote: ref.watch(healthConnectDataSourceProvider),
  );
});

/// Haupt-Provider für die Schritte eines bestimmten Tages basierend auf einem dayOffset.
/// 0 = heute, -1 = gestern, etc.
final dailyStepsProvider = StreamProvider.family<DailyStepStats, int>((ref, dayOffset) {
  ref.keepAlive(); // 👈 State bleibt erhalten wenn Page aus Viewport scrollt

  final date = dateForOffset(dayOffset);
  final repo = ref.watch(stepsRepositoryProvider);
  return repo.watchStepsForDate(date);
});

/// Provider für das aktuelle Schrittziel.
final currentStepGoalProvider = StreamProvider<int>((ref) {
  final repo = ref.watch(stepsRepositoryProvider);
  return repo.watchCurrentGoal();
});
