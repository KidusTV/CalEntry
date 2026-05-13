import '../../domain/entities/step_goal_entity.dart';

class StepGoalModel extends StepGoalEntity {
  const StepGoalModel({
    required super.id,
    required super.dailyGoal,
    required super.updatedAt,
  });

  factory StepGoalModel.fromDrift(dynamic row) {
    return StepGoalModel(
      id: row.id,
      dailyGoal: row.dailyGoal,
      updatedAt: row.updatedAt,
    );
  }

  StepGoalEntity toEntity() => StepGoalEntity(
    id: id,
    dailyGoal: dailyGoal,
    updatedAt: updatedAt,
  );
}