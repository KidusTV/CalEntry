import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_card.dart';

class WeeklyHeatmap extends StatelessWidget {
  const WeeklyHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wochenaktivität',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                    (index) {
                  final strength = [
                    0.2,
                    0.35,
                    0.8,
                    1.0,
                    0.5,
                    0.25,
                    0.7,
                  ][index];

                  return Column(
                    children: [
                      Container(
                        width: 34,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color.lerp(
                                const Color(0x22FF8A5B),
                                const Color(0xFFFF8A5B),
                                strength,
                              )!,
                              Color.lerp(
                                const Color(0x11FF8A5B),
                                const Color(0xFFFFB36B),
                                strength,
                              )!,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ['M', 'D', 'M', 'D', 'F', 'S', 'S'][index],
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.58),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}