import '../../domain/entities/water_goal_entity.dart';

/// Dart-Modell für eine Zeile aus [WaterGoals].
class WaterGoalModel {
  final int id;
  final double dailyGoal;
  final String unit;

  const WaterGoalModel({
    required this.id,
    required this.dailyGoal,
    required this.unit,
  });

  factory WaterGoalModel.fromDrift(dynamic row) {
    return WaterGoalModel(
      id: row.id as int,
      dailyGoal: row.dailyGoal as double,
      unit: row.unit as String,
    );
  }

  WaterGoalEntity toEntity() {
    return WaterGoalEntity(
      id: id,
      dailyGoal: dailyGoal,
      unit: unit,
    );
  }
}