
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_radius.dart';
import '../../../domain/entities/nutrient_entitiy.dart';

class GoalBarItem extends StatelessWidget {
  const GoalBarItem({
    super.key,
    required this.nutrient,
    required this.onSelect,
    required this.isActive,
  });

  final NutrientEntity nutrient;
  final ValueChanged<NutrientEntity> onSelect;
  final bool isActive;

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: isActive ? nutrient.progress : 0,
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        builder: (context, animatedProgress, _) {
          return TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: isActive ? 0 : nutrient.progress,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              builder: (context, animProgress, _) {
                return GestureDetector(
                  onTap: () => onSelect(nutrient),
                  child: Stack(
                    children: [
                      // Umrandung
                      // if (isActive)
                      //   Positioned.fill(
                      //     child: CustomPaint(
                      //       painter: _ProgressBorderPainter(
                      //         progress: animatedProgress,
                      //         isActive: isActive,
                      //       ),
                      //     ),
                      //   ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [

                            // Progress Fill
                            // Positioned.fill(
                            //   child: Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: AnimatedFractionallySizedBox(
                            //       duration: const Duration(milliseconds: 400),
                            //       curve: Curves.easeOut,
                            //       heightFactor: 1,
                            //       widthFactor: animProgress.clamp(0.0, 1.0),
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //           color: const Color(0xFFFFB36B).withOpacity(0.70),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            // Main Container
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.white.withOpacity(0.12)
                                    : Colors.white.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(AppRadius.full),
                                border: Border.all(
                                  color: isActive
                                      ? Colors.greenAccent
                                      : Colors.white.withOpacity(0.05),
                                ),
                              ),
                              child: Text(
                                nutrient.shortLabel,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isActive
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.6),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        }
    );
  }
}