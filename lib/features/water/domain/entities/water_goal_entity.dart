class WaterGoalEntity {
  final int id;
  final double dailyGoal;
  final String unit;

  const WaterGoalEntity({
    required this.id,
    required this.dailyGoal,
    required this.unit,
  });

  @override
  String toString() =>
      'WaterGoalEntity(id: $id, dailyGoal: $dailyGoal, unit: $unit)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WaterGoalEntity &&
              other.id == id &&
              other.dailyGoal == dailyGoal &&
              other.unit == unit;

  @override
  int get hashCode => Object.hash(id, dailyGoal, unit);
}