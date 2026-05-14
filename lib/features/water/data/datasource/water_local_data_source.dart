import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../models/water_entry_model.dart';
import '../models/water_goal_model.dart';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../models/water_entry_model.dart';
import '../models/water_goal_model.dart';

/// Einzige Stelle, die direkt mit Drift / PostgreSQL spricht.
/// Alle anderen Schichten kennen nur Models oder Entities.
class WaterLocalDataSource {
  final AppDatabase db;

  WaterLocalDataSource(this.db);

  // ─── Helpers ─────────────────────────────────────────────────────────────

  static DateTime _startOf(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime _endOf(DateTime date) =>
      DateTime(date.year, date.month, date.day + 1);

  // ─── Entries ────────────────────────────────────────────────────────────────

  /// Liefert einen Stream aller Einträge des heutigen Tages.
  Stream<List<WaterEntryModel>> watchTodayEntries() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    return (db.select(db.waterEntries)
      ..where((tbl) => tbl.createdAt.isBiggerOrEqualValue(startOfDay)))
        .watch()
        .map((rows) => rows.map(WaterEntryModel.fromDrift).toList());
  }

  /// Liefert einen Stream aller Einträge des heutigen Tages.
  /// Stream aller Einträge eines bestimmten Tages.
  Stream<List<WaterEntryModel>> watchEntriesForDate(DateTime date) {
    final start = _startOf(date);
    final end   = _endOf(date);

    return (db.select(db.waterEntries)
      ..where(
            (tbl) =>
        tbl.createdAt.isBiggerOrEqualValue(start) &
        tbl.createdAt.isSmallerThanValue(end),
      )
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
        .watch()
        .map((rows) => rows.map(WaterEntryModel.fromDrift).toList());
  }

  /// Alle Einträge eines bestimmten Tages — nützlich für Statistiken.
  Stream<List<WaterEntryModel>> watchEntriesForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));

    return (db.select(db.waterEntries)
      ..where(
            (tbl) =>
        tbl.createdAt.isBiggerOrEqualValue(start) &
        tbl.createdAt.isSmallerThanValue(end),
      ))
        .watch()
        .map((rows) => rows.map(WaterEntryModel.fromDrift).toList());
  }

  Future<void> insertEntry(WaterEntriesCompanion companion) async {
    final createdAt = companion.createdAt.value;
    double amount = companion.amount.value;

    final startOfDay = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );

    final endOfDay = startOfDay.add(const Duration(days: 1));

    final entries = await (db.select(db.waterEntries)
      ..where((tbl) =>
      tbl.createdAt.isBiggerOrEqualValue(startOfDay) &
      tbl.createdAt.isSmallerThanValue(endOfDay)))
        .get();

    final currentTotal = entries.fold<double>(
      0,
          (sum, e) => sum + e.amount,
    );

    // Negative Entries begrenzen
    if (currentTotal + amount < 0) {
      amount = -currentTotal;
    }

    // Wenn eh nichts mehr übrig
    if (amount == 0) return;

    await db.into(db.waterEntries).insert(
      companion.copyWith(
        amount: Value(amount),
      ),
    );
  }

  Future<void> deleteEntry(String id) {
    return (db.delete(db.waterEntries)
      ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  /// Löscht den neuesten Eintrag des angegebenen Tages — für den −-Button.
  Future<bool> deleteLastEntryForDate(DateTime date) async {
    final start = _startOf(date);
    final end   = _endOf(date);

    final rows = await (db.select(db.waterEntries)
      ..where(
            (tbl) =>
        tbl.createdAt.isBiggerOrEqualValue(start) &
        tbl.createdAt.isSmallerThanValue(end),
      )
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
      ..limit(1))
        .get();

    if (rows.isEmpty) return false;
    await deleteEntry(rows.first.id);
    return true;
  }

  /// Löscht den neuesten Eintrag des heutigen Tages — für den −-Button.
  /// Gibt `true` zurück wenn tatsächlich etwas gelöscht wurde.
  Future<bool> deleteLastTodayEntry() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final rows = await (db.select(db.waterEntries)
      ..where((tbl) => tbl.createdAt.isBiggerOrEqualValue(startOfDay))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
      ..limit(1))
        .get();

    if (rows.isEmpty) return false;
    await deleteEntry(rows.first.id);
    return true;
  }

  // ─── Goals ──────────────────────────────────────────────────────────────────

  /// Liefert immer das aktuell aktive Goal (letzter Eintrag).
  Stream<WaterGoalModel?> watchCurrentGoal() {
    return (db.select(db.waterGoals)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])
      ..limit(1))
        .watch()
        .map((rows) => rows.isEmpty ? null : WaterGoalModel.fromDrift(rows.first));
  }

  Future<void> upsertGoal(WaterGoalsCompanion companion) {
    return db.into(db.waterGoals).insertOnConflictUpdate(companion);
  }
}
// import 'package:drift/water_local_data_source.dart';
//
// import '../../../../core/database/app_database.dart';
// import '../../domain/entities/daily_water_stats.dart';
// import '../../domain/entities/water_entry_entity.dart';
//
// class WaterLocalDataSource {
//   final AppDatabase db;
//
//   WaterLocalDataSource(this.db);
//
//   Stream<List<WaterEntryEntity>> watchTodayEntries() {
//     final now = DateTime.now();
//
//     final startOfDay = DateTime(
//       now.year,
//       now.month,
//       now.day,
//     );
//
//     return (db.select(db.waterEntries)
//       ..where(
//             (tbl) => tbl.createdAt.isBiggerOrEqualValue(startOfDay),
//       ))
//         .watch()
//         .map(
//           (rows) => rows
//           .map(
//             (e) => WaterEntryEntity(
//           id: e.id,
//           amount: e.amount,
//           createdAt: e.createdAt,
//         ),
//       )
//           .toList(),
//     );
//   }
//
//   Future<void> insertEntry(
//       WaterEntryEntity entry,
//       ) async {
//     await db.into(db.waterEntries).insert(
//       WaterEntriesCompanion.insert(
//         id: entry.id,
//         amount: entry.amount,
//         createdAt: entry.createdAt,
//       ),
//     );
//   }
//
//   Future<void> removeEntry(String id) async {
//     await (db.delete(db.waterEntries)
//       ..where((tbl) => tbl.id.equals(id)))
//         .go();
//   }
//
//   Future<void> setGoal(double amount) async {
//     final existing =
//     await db.select(db.waterGoals).getSingleOrNull();
//
//     if (existing == null) {
//       await db.into(db.waterGoals).insert(
//         WaterGoalsCompanion.insert(
//           dailyGoal: amount,
//           unit: 'ml',
//         ),
//       );
//     } else {
//       await (db.update(db.waterGoals)
//         ..where((tbl) => tbl.id.equals(existing.id)))
//           .write(
//         WaterGoalsCompanion(
//           dailyGoal: Value(amount),
//         ),
//       );
//     }
//   }
//
//   Future<double> getGoal() async {
//     final goal =
//     await db.select(db.waterGoals).getSingleOrNull();
//
//     return goal?.dailyGoal ?? 3000;
//   }
// }