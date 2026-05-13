import '../entities/daily_water_stats.dart';
import '../repositories/water_repository.dart';

class WatchStatsForDateUseCase {
  final WaterRepository _repository;

  const WatchStatsForDateUseCase(this._repository);

  Stream<DailyWaterStats> call(DateTime date) => _repository.watchStatsForDate(date);
}