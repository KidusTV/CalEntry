import '../../domain/entities/daily_step_stats.dart';

class StepSnapshotModel extends DailyStepStats {
  final bool isFinal;

  const StepSnapshotModel({
    required super.day,
    required super.steps,
    required super.goal,
    required super.updatedAt,
    required this.isFinal,
  });

  factory StepSnapshotModel.fromDrift(dynamic row, {int goal = 10000}) {
    return StepSnapshotModel(
      day: row.day,
      steps: row.steps,
      goal: goal,
      updatedAt: row.updatedAt,
      isFinal: row.isFinal
    );
  }
}