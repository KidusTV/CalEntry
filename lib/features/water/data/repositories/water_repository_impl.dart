import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/daily_water_stats.dart';
import '../../domain/entities/water_entry_entity.dart';
import '../../domain/entities/water_goal_entity.dart';
import '../../domain/repositories/water_repository.dart';
import '../datasource/water_local_data_source.dart';

class WaterRepositoryImpl implements WaterRepository {
  final WaterLocalDataSource _local;

  static const _defaultGoal = 3000.0;
  static const _defaultUnit = 'ml';

  WaterRepositoryImpl(this._local);

  // ─── Entries ────────────────────────────────────────────────────────────────

  @override
  Stream<List<WaterEntryEntity>> watchTodayEntries() {
    return _local
        .watchTodayEntries()
        .map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Stream<List<WaterEntryEntity>> watchEntriesForDate(DateTime date) {
    return _local
        .watchEntriesForDate(date)
        .map((models) => models.map((m) => m.toEntity()).toList());
  }

  // ─── Stats ──────────────────────────────────────────────────────────────────

  @override
  Stream<DailyWaterStats> watchTodayStats() {
    // Kombiniert Entries + Goal in einem einzigen Stream.
    return _local.watchTodayEntries().asyncMap((entries) async {
      final consumed = entries.fold<double>(0, (sum, e) => sum + e.amount);

      final goalModel = await _local.watchCurrentGoal().first;
      final goal = goalModel?.dailyGoal ?? _defaultGoal;
      final unit = goalModel?.unit ?? _defaultUnit;

      return DailyWaterStats(
        consumed: consumed,
        goal: goal,
        unit: unit,
        // Streak-Berechnung kann später über eine eigene UseCase-Klasse erfolgen.
        streak: 0,
      );
    });
  }

  @override
  Stream<DailyWaterStats> watchStatsForDate(DateTime date) {
    return _local.watchEntriesForDate(date).asyncMap((entries) async {
      final consumed = entries.fold<double>(0, (sum, e) => sum + e.amount);
      final goalModel = await _local.watchCurrentGoal().first;
      final goal = goalModel?.dailyGoal ?? _defaultGoal;
      final unit = goalModel?.unit ?? _defaultUnit;

      return DailyWaterStats(
        consumed: consumed,
        goal: goal,
        unit: unit,
        streak: 0,
      );
    });
  }

  // ─── Mutations ──────────────────────────────────────────────────────────────

  @override
  Future<void> addDrink(double amount, {required DateTime date}) async {
    // createdAt wird auf den angezeigten Tag gesetzt (Mitternacht + jetzt-Zeit),
    // damit vergangene Tage korrekt befüllt werden können.
    final now = DateTime.now();
    final createdAt = DateTime(
      date.year, date.month, date.day,
      now.hour, now.minute, now.second,
    );
    final companion = WaterEntriesCompanion.insert(
      id: const Uuid().v4(),
      amount: amount,
      createdAt: createdAt,
    );
    await _local.insertEntry(companion);
  }

  @override
  Future<void> removeLastDrink({required DateTime date}) {
    return _local.deleteLastEntryForDate(date);
  }

  @override
  Future<void> removeEntry(String id) {
    return _local.deleteEntry(id);
  }

  @override
  Future<void> setGoal(double amount, {String unit = _defaultUnit}) async {
    final companion = WaterGoalsCompanion.insert(
      dailyGoal: amount,
      unit: unit,
    );
    await _local.upsertGoal(companion);
  }

  // ─── Goal ───────────────────────────────────────────────────────────────────

  @override
  Stream<WaterGoalEntity?> watchCurrentGoal() {
    return _local
        .watchCurrentGoal()
        .map((model) => model?.toEntity());
  }
}

// import '../../data/datasources/water_local_data_source.dart';
// import '../entities/daily_water_stats.dart';
// import '../entities/water_entry_entity.dart';

// import '../../data/repositories/water_repository.dart';

//
// class WaterRepositoryImpl implements WaterRepository {
//   final WaterLocalDataSource local;
//
//   WaterRepositoryImpl(this.local);
//
//   @override
//   Future<void> addDrink(double amount) async {
//     await local.insertEntry(
//       WaterEntryEntity(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         amount: amount,
//         createdAt: DateTime.now(),
//       ),
//     );
//   }
//
//   @override
//   Future<void> removeEntry(String id) async {
//     await local.removeEntry(id);
//   }
//
//   @override
//   Future<void> setGoal(double amount) async {
//     await local.setGoal(amount);
//   }
//
//   @override
//   Stream<List<WaterEntryEntity>> watchTodayEntries() {
//     return local.watchTodayEntries();
//   }
//
//   @override
//   Stream<DailyWaterStats> watchTodayStats() {
//     return local.watchTodayEntries().asyncMap((entries) async {
//       final goal = await local.getGoal();
//
//       final consumed = entries.fold<double>(
//         0,
//             (sum, entry) => sum + entry.amount,
//       );
//
//       return DailyWaterStats(
//         consumed: consumed,
//         goal: goal,
//         streak: 0,
//       );
//     });
//   }
// }