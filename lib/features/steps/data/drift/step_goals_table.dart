import 'package:drift/drift.dart';

class StepGoals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dailyGoal => integer().withDefault(const Constant(10000))();
  DateTimeColumn get updatedAt => dateTime()();
}