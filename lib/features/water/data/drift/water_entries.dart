import 'package:drift/drift.dart';

class WaterEntries extends Table {
  TextColumn get id => text()();

  RealColumn get amount => real()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}