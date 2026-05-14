import 'package:drift/drift.dart';
import '../../../../../core/database/app_database.dart';
import '../../models/step_snapshot_model.dart';
import '../../models/step_goal_model.dart';
import 'package:rxdart/rxdart.dart';

class StepLocalDataSource {
  final AppDatabase db;

  StepLocalDataSource(this.db);



  Future<bool> isDayFinalized(DateTime day) async {
    final StepSnapshotModel? snapshot = await getSteps(day);
    return snapshot?.isFinal ?? false; // isFinal muss auch ins Model
  }

  // ─── Snapshots ─────────────────────────────────────────────────────────────

  Future<void> saveSteps({
    required DateTime day,
    required int steps,
    bool isFinal = false,
  }) async {
    final normalized = DateTime(day.year, day.month, day.day);
    await db.into(db.stepSnapshots).insert(
      StepSnapshotsCompanion(
        day: Value(normalized),
        steps: Value(steps),
        updatedAt: Value(DateTime.now()),
        isFinal: Value(isFinal),
      ),
      onConflict: DoUpdate(
            (old) => StepSnapshotsCompanion.custom(
          steps: Variable(steps),
          updatedAt: Variable(DateTime.now()),
          isFinal: Variable(isFinal),
        ),
        target: [db.stepSnapshots.day],
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

    final snapshotStream = (db.select(db.stepSnapshots)
      ..where((t) => t.day.equals(normalized)))
        .watchSingleOrNull();

    final goalStream = (db.select(db.stepGoals)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1))
        .watchSingleOrNull();

    return Rx.combineLatest2(
      snapshotStream,
      goalStream,
          (snapshot, goal) {
        if (snapshot == null) return null;
        return StepSnapshotModel.fromDrift(
          snapshot,
          goal: goal?.dailyGoal ?? 10000,
        );
      },
    );
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