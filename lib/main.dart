import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workmanager/workmanager.dart';

import 'core/database/app_database.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'features/steps/background/steps_sync_worker.dart';
import 'features/water/presentation/providers/water_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Health Connect Permissions beim Start anfragen
  final health = Health();
  await health.requestAuthorization(
    [HealthDataType.STEPS],
    permissions: [HealthDataAccess.READ],
  );

  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    'steps-sync',
    syncStepsTask,
    frequency: const Duration(hours: 1),
  );

  initializeDateFormatting('de_DE');

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(AppDatabase()),
      ],
      child: PremiumTrackingApp(),
    ),
  );
}

class PremiumTrackingApp extends StatelessWidget {
  const PremiumTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Momentum',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}