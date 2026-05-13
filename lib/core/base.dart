import 'package:calentry/core/widgets/floating_island_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

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


      case '/settings':
        return 4;

      default:
        return 0;
    }
  }


  void _onItemTapped(BuildContext context, int index, int currentIndex) {
    HapticFeedback.lightImpact();

    if (index == currentIndex) return;

    switch (index) {
      case 0:
        context.go('/home');
        break;

      case 2:
        context.push('/scanner');
        break;

      case 4:
        context.go('/settings');
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
          onChanged: (index) => _onItemTapped(context, index, currentIndex),
        ),
        body: child
    );
  }
}
