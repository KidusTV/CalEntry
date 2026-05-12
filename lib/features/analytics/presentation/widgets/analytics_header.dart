import 'package:flutter/material.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analyse',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -1.4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Deine Entwicklung der letzten Wochen.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.58),
            ),
          ),
        ],
      ),
    );
  }
}