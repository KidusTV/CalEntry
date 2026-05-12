import 'package:flutter/material.dart';

class FoodDetailHeader extends StatelessWidget {
  const FoodDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.white.withValues(alpha: 0.05),
              ),
              child: const Row(
                children: [
                  Text(
                    'Mittagessen',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Hero(
          tag: 'food_image',
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(42),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.12),
                  Colors.white.withValues(alpha: 0.03),
                ],
              ),
            ),
            child: const Icon(
              Icons.fastfood_rounded,
              size: 58,
              color: Colors.white54,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'High Protein Pudding',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Ehrmann',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.54),
          ),
        ),
      ],
    );
  }
}