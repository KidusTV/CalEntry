import 'package:drift/drift.dart';

import '../../../../../core/database/app_database.dart';
import '../../../domain/entities/daily_step_stats.dart';
import '../../models/step_snapshot_model.dart';

class StepLocalDataSource {
  final AppDatabase db;

  StepLocalDataSource(this.db);

  Future<void> saveSteps({
    required DateTime day,
    required int steps,
  }) async {
    await db.into(db.stepSnapshots).insertOnConflictUpdate(
      StepSnapshotsCompanion(
        day: Value(day),
        steps: Value(steps),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<StepSnapshotModel?> getSteps(
      DateTime day,
      ) async {
    final normalized = DateTime(
      day.year,
      day.month,
      day.day,
    );

    final row = await (
        db.select(db.stepSnapshots)
          ..where((t) => t.day.equals(normalized))
    ).getSingleOrNull();

    if (row == null) return null;

    return StepSnapshotModel.fromDrift(row);
  }

  Stream<DailyStepStats?> watchSteps(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);

    return (db.select(db.stepSnapshots)
      ..where((t) => t.day.equals(normalized)))
        .watch()
        .map((rows) {
      if (rows.isEmpty) return null;

      final row = rows.first;

      return StepSnapshotModel.fromDrift(row);
    });
  }
}