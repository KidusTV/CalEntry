import 'package:calentry/core/base.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/scanner/presentation/pages/scanner_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

final appRouter = GoRouter(
  initialLocation: '/home',

  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BasePage(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),

        GoRoute(
          path: '/scanner',
          builder: (context, state) => const ScannerPage(),
        ),

        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        )
      ]
    )

  ],
);