/// Aggregierte Tagesstatistik — wird direkt im UI konsumiert.
class DailyWaterStats {
  final double consumed;
  final double goal;
  final String unit;
  final int streak;

  const DailyWaterStats({
    required this.consumed,
    required this.goal,
    required this.unit,
    required this.streak,
  });

  /// Fortschritt zwischen 0.0 und 1.0.
  double get progress => goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;

  /// Ob das Tagesziel erreicht wurde.
  bool get isGoalReached => consumed >= goal;

  /// Verbleibende Menge bis zum Ziel.
  double get remaining => (goal - consumed).clamp(0.0, double.infinity);

  @override
  String toString() =>
      'DailyWaterStats(consumed: $consumed, goal: $goal, unit: $unit, streak: $streak)';
}