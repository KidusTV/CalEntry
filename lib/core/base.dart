import 'package:calentry/core/widgets/app_bar.dart';
import 'package:calentry/core/widgets/floating_island_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/scanner/presentation/pages/scanner_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;

  const BasePage({ super.key, required this.child, });



  int _locationToIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case '/home':
        return 0;

      case '/scanner':
        return 2;

      default:
        return 0;
    }
  }


  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;

      case 2:
        context.push('/scanner');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _locationToIndex(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: (currentIndex == 2) ? null : FloatingIslandNavbar(
          currentIndex: currentIndex, // unabhängig davon
          onChanged: (index) => _onItemTapped(context, index),
        ),
        body: child
    );
  }
}
