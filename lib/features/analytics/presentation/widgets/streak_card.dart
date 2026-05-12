import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_card.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GlassCard(
        child: Row(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFB36B),
                    Color(0xFFFF7D54),
                  ],
                ),
              ),
              child: const Icon(
                Icons.local_fire_department_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '12 Tage Streak',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Du erreichst dein Kalorienziel aktuell deutlich konstanter.',
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}