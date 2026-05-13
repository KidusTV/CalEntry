import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/water_providers.dart';

/// Controller-Schicht zwischen UI und UseCases.
/// Jede schreibende Aktion bekommt den [dayOffset] des gerade angezeigten Tages,
/// damit Einträge immer dem richtigen Tag zugeordnet werden.
class WaterController {
  final Ref _ref;

  const WaterController(this._ref);

  Future<void> addDrink(double amount, {required int dayOffset}) async {
    final date = dateForOffset(dayOffset);
    await _ref.read(addDrinkUseCaseProvider).call(amount, date: date);
  }

  Future<void> removeLastDrink({required int dayOffset}) async {
    final date = dateForOffset(dayOffset);
    await _ref.read(removeLastDrinkUseCaseProvider).call(date: date);
  }

  /// Für Swipe-to-delete — ID reicht, kein dayOffset nötig.
  Future<void> removeEntry(String id) async {
    await _ref.read(removeEntryUseCaseProvider).call(id);
  }

  Future<void> setGoal(double amount, {String unit = 'ml'}) async {
    await _ref.read(setGoalUseCaseProvider).call(amount, unit: unit);
  }
}

final waterControllerProvider = Provider<WaterController>((ref) {
  return WaterController(ref);
});