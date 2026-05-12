import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_card.dart';

class FoodMacroSection extends StatelessWidget {
  const FoodMacroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: const [
          _MacroRow(
            title: 'Kalorien',
            value: '220 kcal',
          ),
          SizedBox(height: 18),
          _MacroRow(
            title: 'Proteine',
            value: '20 g',
          ),
          SizedBox(height: 18),
          _MacroRow(
            title: 'Fette',
            value: '3.4 g',
          ),
          SizedBox(height: 18),
          _MacroRow(
            title: 'Zucker',
            value: '8.1 g',
          ),
        ],
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  final String title;
  final String value;

  const _MacroRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.58),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}