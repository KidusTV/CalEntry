import 'package:drift/drift.dart';

class StepSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Start des Tages (00:00)
  DateTimeColumn get day => dateTime().unique()();

  /// Gesamt-Schritte des Tages
  IntColumn get steps => integer()();

  /// Wann zuletzt synchronisiert
  DateTimeColumn get updatedAt => dateTime()();
}