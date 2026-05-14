import 'package:health/health.dart';

class HealthConnectStepsDataSource {
  final Health health;

  static const _permissions = [
    HealthDataAccess.READ,
  ];

  static const _types = [
    HealthDataType.STEPS,
  ];

  HealthConnectStepsDataSource(this.health);

  Future<bool> requestPermissions() async {
    return await health.requestAuthorization(_types, permissions: _permissions);
  }

  Future<bool> hasPermissions() async {
    return await health.hasPermissions(_types, permissions: _permissions) ?? false;
  }

  Future<int> getStepsForDay(DateTime day) async {
    final hasPerms = await hasPermissions();
    if (!hasPerms) {
      final granted = await requestPermissions();
      if (!granted) return 0; // Kein Crash, kein Log-Spam
    }

    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return await health.getTotalStepsInInterval(start, end) ?? 0;
  }

}