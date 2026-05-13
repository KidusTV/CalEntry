import 'package:drift/drift.dart';

class WaterGoals extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get dailyGoal => real()();

  TextColumn get unit => text()();
}