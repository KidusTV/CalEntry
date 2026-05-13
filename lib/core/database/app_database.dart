import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import '../../features/steps/data/drift/step_snapshots_table.dart';
import '../../features/steps/data/drift/step_goals_table.dart';
import '../../features/water/data/drift/water_entries.dart';
import '../../features/water/data/drift/water_goals.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [WaterEntries, WaterGoals, StepSnapshots, StepGoals])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2; // Erhöht von 1 auf 2

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          // Erstellt die neuen Tabellen für das Steps-System
          await m.createTable(stepSnapshots);
          await m.createTable(stepGoals);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir  = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'app.db'));
      return NativeDatabase(file);
    });
  }
}