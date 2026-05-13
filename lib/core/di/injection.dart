import '../../core/database/app_database.dart';
import '../../features/steps/data/datasources/local/step_local_datasource.dart';
import '../../features/steps/data/datasources/remote/health_connect_steps_datasource.dart';
import '../../features/steps/data/repositories/steps_repository_impl.dart';
import '../../features/steps/domain/usecases/sync_steps_usecase.dart';
import 'package:health/health.dart';

class WorkerDI {
  static late SyncStepsUseCase syncStepsUseCase;

  static Future<void> init() async {
    final db = AppDatabase();
    final health = Health();

    final local = StepLocalDataSource(db);
    final remote = HealthConnectStepsDataSource(health);

    final repo = StepsRepositoryImpl(
      local: local,
      remote: remote,
    );

    syncStepsUseCase = SyncStepsUseCase(repo);
  }
}