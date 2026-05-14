import 'dart:async';
import '../../domain/entities/daily_step_stats.dart';
import '../../domain/repositories/steps_repository.dart';
import '../datasources/local/step_local_datasource.dart';
import '../datasources/remote/health_connect_steps_datasource.dart';

class StepsRepositoryImpl implements StepsRepository {
  final StepLocalDataSource _local;
  final HealthConnectStepsDataSource _remote;

  // Welche Tage wurden in dieser App-Session bereits gesynct?
  final Set<DateTime> _syncedDates = {};

  StepsRepositoryImpl({
    required StepLocalDataSource local,
    required HealthConnectStepsDataSource remote,
  })  : _local = local,
        _remote = remote;

  @override
  Stream<DailyStepStats> watchStepsForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    unawaited(_syncIfNeeded(normalizedDate));

    return _local.watchSteps(normalizedDate).map((snapshot) {
      if (snapshot != null) return snapshot;
      return DailyStepStats(
        day: normalizedDate,
        steps: 0,
        goal: 10000,
        updatedAt: DateTime.now(),
      );
    });
  }

  final Set<DateTime> _syncedThisSession = {};

  Future<void> _syncIfNeeded(DateTime date) async {
    final isToday = date == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (isToday) {
      // Heute: einmal pro Session syncen
      if (_syncedThisSession.contains(date)) return;
      _syncedThisSession.add(date);
      await syncSteps(date, isFinal: false);
    } else {
      // Vergangener Tag: nur wenn noch nicht finalisiert
      if (await _local.isDayFinalized(date)) return;
      await syncSteps(date, isFinal: true);
    }
  }

  @override
  Future<void> syncSteps(DateTime date, {bool isFinal = false}) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    try {
      final steps = await _remote.getStepsForDay(normalizedDate);
      await _local.saveSteps(day: normalizedDate, steps: steps, isFinal: isFinal);
    } catch (_) {}
  }


  @override
  Future<void> setGoal(int steps) async {
    await _local.upsertGoal(steps);
  }

  @override
  Stream<int> watchCurrentGoal() {
    return _local.watchCurrentGoal().map((goal) => goal?.dailyGoal ?? 10000);
  }
}

// class StepsRepositoryImpl implements StepsRepository {
//   final StepLocalDataSource _local;
//   final HealthConnectStepsDataSource _remote;
//
//   StepsRepositoryImpl({
//     required StepLocalDataSource local,
//     required HealthConnectStepsDataSource remote,
//   })  : _local = local,
//         _remote = remote;
//
//   @override
//   Stream<DailyStepStats> watchStepsForDate(DateTime date) {
//     final normalizedDate = DateTime(date.year, date.month, date.day);
//
//     // Sync immer triggern beim ersten Watch — Stream hält sich selbst aktuell
//     unawaited(_triggerBackgroundSyncIfNeeded(normalizedDate));
//
//     return _local.watchSteps(normalizedDate).map((snapshot) {
//       if (snapshot != null) return snapshot;
//       return DailyStepStats(
//         day: normalizedDate,
//         steps: 0,
//         goal: 10000,
//         updatedAt: DateTime.now(),
//       );
//     });
//   }
//
//   @override
//   Future<void> syncSteps(DateTime date) async {
//     final normalizedDate = DateTime(date.year, date.month, date.day);
//     try {
//       final steps = await _remote.getStepsForDay(normalizedDate);
//       await _local.saveSteps(day: normalizedDate, steps: steps);
//     } catch (e) {
//       // Still schlucken, um UI nicht zu stören
//     }
//   }
//
//   @override
//   Future<void> setGoal(int steps) async {
//     await _local.upsertGoal(steps);
//   }
//
//   @override
//   Stream<int> watchCurrentGoal() {
//     return _local.watchCurrentGoal().map((goal) => goal?.dailyGoal ?? 10000);
//   }
//
//   /// Prüft das Alter der Daten und sync nur, wenn sie älter als 10 Min sind.
//   Future<void> _triggerBackgroundSyncIfNeeded(DateTime date) async {
//     final cached = await _local.getSteps(date);
//
//     if (cached != null) {
//       final age = DateTime.now().difference(cached.updatedAt);
//       if (age < const Duration(minutes: 10)) {
//         return; // Daten sind frisch genug, kein Sync nötig -> Kein Log-Spam
//       }
//     }
//
//     // Im Hintergrund ausführen
//     unawaited(syncSteps(date));
//   }
// }