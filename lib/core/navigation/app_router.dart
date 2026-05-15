import 'package:calentry/core/base.dart';
import 'package:calentry/features/analytics/presentation/pages/analytics_page.dart';
import 'package:flutter/material.dart';
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
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: HomePage(),
          ),
        ),

        GoRoute(
          path: '/analytics',
          builder: (context, state) => const AnalyticsPage(),
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: AnalyticsPage(),
          ),
        ),

        GoRoute(
          path: '/scanner',
          builder: (context, state) => const ScannerPage(),
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: ScannerPage(),
          ),
        ),

        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
          // pageBuilder: (BuildContext context, GoRouterState state) => buildPageWithoutAnimation(
          //   context: context,
          //   state: state,
          //   child: SettingsPage(),
          // ),
        )
      ]
    )

  ],
);