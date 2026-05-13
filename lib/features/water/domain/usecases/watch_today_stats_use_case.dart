import '../entities/daily_water_stats.dart';
import '../repositories/water_repository.dart';

class WatchTodayStatsUseCase {
  final WaterRepository _repository;

  const WatchTodayStatsUseCase(this._repository);

  Stream<DailyWaterStats> call() => _repository.watchTodayStats();
}