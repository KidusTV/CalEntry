import 'package:flutter/material.dart';

class PremiumScaffold extends StatelessWidget {
  final Widget body;

  const PremiumScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF141417),
              Color(0xFF09090B),
            ],
          ),
        ),
        child: body,
      ),
    );
  }
}