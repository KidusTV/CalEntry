import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';

import '../../../water/presentation/providers/water_providers.dart';
import '../../data/datasources/local/step_local_datasource.dart';
import '../../data/datasources/remote/health_connect_steps_datasource.dart';
import '../../data/repositories/steps_repository_impl.dart';
import '../../domain/repositories/steps_repository.dart';
import '../../domain/usecases/get_daily_steps_usecase.dart';

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
    local: ref.read(stepLocalDataSourceProvider),
    remote: ref.read(healthConnectDataSourceProvider),
  );
});

// final stepsProvider =FutureProvider.family<int, DateTime>((ref, date) async {
//   final usecase = ref.read(getDailyStepsUseCaseProvider);
//
//   final result = await usecase(date);
//
//   return result.steps;
// });
final stepsProvider = StreamProvider.family<int, DateTime>((ref, date) {
  final repo = ref.read(stepsRepositoryProvider);

  return repo.watchDailySteps(date).map((e) => e?.steps ?? 0);
});

final getDailyStepsUseCaseProvider = Provider<GetDailyStepsUseCase>((ref) {
  return GetDailyStepsUseCase(ref.read(stepsRepositoryProvider));
});