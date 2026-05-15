import 'package:flutter/material.dart';

class WaterLabel extends StatelessWidget {
  final int displayedMl;
  const WaterLabel({super.key, required this.displayedMl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const ValueKey('label'),
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '$displayedMl',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.0,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
          Positioned(
            top: 25,
            child: Opacity(
              opacity: 0.8,
              child: const Icon(Icons.water_drop, color: Colors.white, size: 14),
            ),
          ),
          Positioned(
            bottom: 25,
            child: Text(
              'ml',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
