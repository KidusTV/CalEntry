class DailyStepStats {
  final DateTime day;
  final int steps;
  final int goal;
  final DateTime updatedAt;

  const DailyStepStats({
    required this.day,
    required this.steps,
    required this.goal,
    required this.updatedAt,
  });

  double get progress => (steps / goal).clamp(0.0, 1.0);
}