import 'package:drift/drift.dart';
import '../../../../../core/database/app_database.dart';
import '../../models/step_snapshot_model.dart';
import '../../models/step_goal_model.dart';

class StepLocalDataSource {
  final AppDatabase db;

  StepLocalDataSource(this.db);

  // ─── Snapshots ─────────────────────────────────────────────────────────────

  Future<void> saveSteps({
    required DateTime day,
    required int steps,
  }) async {
    final normalized = DateTime(day.year, day.month, day.day);
    await db.into(db.stepSnapshots).insertOnConflictUpdate(
      StepSnapshotsCompanion(
        day: Value(normalized),
        steps: Value(steps),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<StepSnapshotModel?> getSteps(DateTime day) async {
    final normalized = DateTime(day.year, day.month, day.day);
    final row = await (db.select(db.stepSnapshots)
          ..where((t) => t.day.equals(normalized)))
        .getSingleOrNull();

    if (row == null) return null;
    
    final goal = await getCurrentGoal();
    return StepSnapshotModel.fromDrift(row, goal: goal?.dailyGoal ?? 10000);
  }

  Stream<StepSnapshotModel?> watchSteps(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);

    return (db.select(db.stepSnapshots)
          ..where((t) => t.day.equals(normalized)))
        .watchSingleOrNull()
        .asyncMap((row) async {
      if (row == null) return null;
      final goal = await getCurrentGoal();
      return StepSnapshotModel.fromDrift(row, goal: goal?.dailyGoal ?? 10000);
    });
  }

  // ─── Goals ──────────────────────────────────────────────────────────────────

  Future<StepGoalModel?> getCurrentGoal() async {
    final row = await (db.select(db.stepGoals)
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .getSingleOrNull();
    
    if (row == null) return null;
    return StepGoalModel.fromDrift(row);
  }

  Stream<StepGoalModel?> watchCurrentGoal() {
    return (db.select(db.stepGoals)
          ..orderBy([(t) => OrderingTerm.desc(t.id)])
          ..limit(1))
        .watchSingleOrNull()
        .map((row) => row != null ? StepGoalModel.fromDrift(row) : null);
  }

  Future<void> upsertGoal(int amount) async {
    await db.into(db.stepGoals).insertOnConflictUpdate(
      StepGoalsCompanion.insert(
        dailyGoal: Value(amount),
        updatedAt: DateTime.now(),
      ),
    );
  }
}