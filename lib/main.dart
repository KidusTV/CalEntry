import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('de_DE');
  runApp(
    const ProviderScope(
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