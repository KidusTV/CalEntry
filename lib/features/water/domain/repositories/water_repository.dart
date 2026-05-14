import '../entities/daily_water_stats.dart';
import '../entities/water_entry_entity.dart';
import '../entities/water_goal_entity.dart';

/// Abstrakte Schnittstelle — die einzige Sache,
/// die Domain und Presentation je über Daten wissen müssen.
abstract class WaterRepository {
  /// Stream aller Einträge des heutigen Tages.
  Stream<List<WaterEntryEntity>> watchTodayEntries();

  /// Stream der aggregierten Tagesstatistik.
  Stream<DailyWaterStats> watchTodayStats();

  /// Stream des aktuell aktiven Goals.
  Stream<WaterGoalEntity?> watchCurrentGoal();

  /// Stream aller Einträge eines bestimmten Tages.
  Stream<List<WaterEntryEntity>> watchEntriesForDate(DateTime date);

  /// Stream der aggregierten Statistik eines bestimmten Tages.
  Stream<DailyWaterStats> watchStatsForDate(DateTime date);

  /// Fügt einen Drink hinzu.
  /// Fügt einen Drink für einen bestimmten Tag hinzu.
  Future<void> addDrink(double amount, {required DateTime date});

  Future<void> removeDrink(double amount, {required DateTime date});

  /// ~~Löscht den neuesten Eintrag des heutigen Tages (−-Button).~~
  /// Löscht den neuesten Eintrag eines bestimmten Tages (−-Button).
  Future<void> removeLastDrink({required DateTime date});

  /// Löscht einen spezifischen Eintrag per ID (Swipe-to-delete).
  Future<void> removeEntry(String id);

  /// Setzt / aktualisiert das Tagesziel.
  Future<void> setGoal(double amount, {String unit});
}

// import '../../domain/entities/daily_water_stats.dart';
// import '../../domain/entities/water_entry_entity.dart';
//
// abstract class WaterRepository {
//   Stream<List<WaterEntryEntity>> watchTodayEntries();
//
//   Stream<DailyWaterStats> watchTodayStats();
//
//   Future<void> addDrink(double amount);
//
//   Future<void> removeEntry(String id);
//
//   Future<void> setGoal(double amount);
// }