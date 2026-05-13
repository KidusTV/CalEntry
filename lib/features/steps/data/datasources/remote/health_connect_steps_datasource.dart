import 'package:health/health.dart';

class HealthConnectStepsDataSource {
  final Health health;

  HealthConnectStepsDataSource(this.health);

  Future<int> getStepsForDay(DateTime day) async {
    final start = DateTime(
      day.year,
      day.month,
      day.day,
    );

    final end = start.add(const Duration(days: 1));

    final steps = await health.getTotalStepsInInterval(
      start,
      end,
    );

    return steps ?? 0;
  }
}