import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../data/datasource/water_local_data_source.dart';
import '../../data/repositories/water_repository_impl.dart';
import '../../domain/entities/daily_water_stats.dart';
import '../../domain/entities/water_entry_entity.dart';
import '../../domain/entities/water_goal_entity.dart';
import '../../domain/repositories/water_repository.dart';
import '../../domain/usecases/add_drink_use_case.dart';
import '../../domain/usecases/remove_entry_use_case.dart';
import '../../domain/usecases/remove_last_drink_use_case.dart';
import '../../domain/usecases/set_goal_use_case.dart';
import '../../domain/usecases/watch_stats_for_date_use_case.dart';
import '../../domain/usecases/watch_today_stats_use_case.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Helper
// ─────────────────────────────────────────────────────────────────────────────

/// Rechnet einen dayOffset in ein konkretes DateTime (Mitternacht) um.
///   0  → heute
///  -1  → gestern
///  +1  → morgen
DateTime dateForOffset(int dayOffset) {
  final now   = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return today.add(Duration(days: dayOffset));
}

// ─────────────────────────────────────────────────────────────────────────────
// Infrastructure
// ─────────────────────────────────────────────────────────────────────────────

/// Muss in main.dart per ProviderScope.overrides injiziert werden:
/// ```dart
/// appDatabaseProvider.overrideWithValue(AppDatabase())
/// ```
final appDatabaseProvider = Provider<AppDatabase>(
      (_) => throw UnimplementedError('AppDatabase nicht initialisiert.'),
);

final waterLocalDataSourceProvider = Provider<WaterLocalDataSource>((ref) {
  return WaterLocalDataSource(ref.watch(appDatabaseProvider));
});

// ─────────────────────────────────────────────────────────────────────────────
// Repository
// ─────────────────────────────────────────────────────────────────────────────

final waterRepositoryProvider = Provider<WaterRepository>((ref) {
  return WaterRepositoryImpl(ref.watch(waterLocalDataSourceProvider));
});

// ─────────────────────────────────────────────────────────────────────────────
// UseCases
// ─────────────────────────────────────────────────────────────────────────────

final addDrinkUseCaseProvider = Provider<AddDrinkUseCase>((ref) {
  return AddDrinkUseCase(ref.watch(waterRepositoryProvider));
});

final removeEntryUseCaseProvider = Provider<RemoveEntryUseCase>((ref) {
  return RemoveEntryUseCase(ref.watch(waterRepositoryProvider));
});

final removeLastDrinkUseCaseProvider = Provider<RemoveLastDrinkUseCase>((ref) {
  return RemoveLastDrinkUseCase(ref.watch(waterRepositoryProvider));
});

final setGoalUseCaseProvider = Provider<SetGoalUseCase>((ref) {
  return SetGoalUseCase(ref.watch(waterRepositoryProvider));
});

final watchStatsForDateUseCaseProvider = Provider<WatchStatsForDateUseCase>((ref) {
  return WatchStatsForDateUseCase(ref.watch(waterRepositoryProvider));
});

// ─────────────────────────────────────────────────────────────────────────────
// Stream Providers (family → je ein Slot pro dayOffset)
// ─────────────────────────────────────────────────────────────────────────────
//
// Verwendung im Widget:
//   ref.watch(waterStatsProvider(0))    // heute
//   ref.watch(waterStatsProvider(-1))   // gestern
//   ref.watch(waterStatsProvider(1))    // morgen

/// Aggregierte Tagesstatistik für einen bestimmten Tag.
final waterStatsProvider =
StreamProvider.family<DailyWaterStats, int>((ref, dayOffset) {
  final date = dateForOffset(dayOffset);
  return ref.watch(watchStatsForDateUseCaseProvider).call(date);
});

/// Einzelne Einträge eines bestimmten Tages (z. B. für Timeline/Liste).
final waterEntriesProvider =
StreamProvider.family<List<WaterEntryEntity>, int>((ref, dayOffset) {
  final date = dateForOffset(dayOffset);
  return ref.watch(waterRepositoryProvider).watchEntriesForDate(date);
});

/// Aktuell aktives Tagesziel — global, kein dayOffset nötig.
final currentWaterGoalProvider = StreamProvider<WaterGoalEntity?>((ref) {
  return ref.watch(waterRepositoryProvider).watchCurrentGoal();
});