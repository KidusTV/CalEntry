import '../entities/daily_step_stats.dart';

abstract class StepsRepository {
  /// Stream der Schritte für einen bestimmten Tag.
  /// Liefert sofort Daten aus der DB und triggert ggf. einen Sync.
  Stream<DailyStepStats> watchStepsForDate(DateTime date);

  /// Manueller Sync mit Health Connect.
  Future<void> syncSteps(DateTime date);

  /// Setzt das tägliche Schrittziel.
  Future<void> setGoal(int steps);

  /// Stream des aktuellen Schrittziels.
  Stream<int> watchCurrentGoal();
}