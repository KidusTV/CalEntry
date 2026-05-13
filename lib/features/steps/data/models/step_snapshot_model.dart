import '../../domain/entities/daily_step_stats.dart';

class StepSnapshotModel extends DailyStepStats {
  const StepSnapshotModel({
    required super.day,
    required super.steps,
    required super.updatedAt,
  });

  factory StepSnapshotModel.fromDrift(dynamic row) {
    return StepSnapshotModel(
      day: row.day,
      steps: row.steps,
      updatedAt: row.updatedAt,
    );
  }
}