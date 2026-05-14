import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../domain/entities/nutrient_entitiy.dart';
import 'goal_switch_bar.dart';


class OverviewSection extends StatefulWidget {
  final NutrientEntity focusedNutrient;
  final List<NutrientEntity> nutrients;
  final int dayOffset;
  final ValueChanged<NutrientEntity> onGoalFocused;

  const OverviewSection({
    super.key,
    required this.dayOffset,
    required this.focusedNutrient,
    required this.nutrients,
    required this.onGoalFocused,
  });

  @override
  State<OverviewSection> createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _progressAnim;
  late Animation<double> _currentMain;
  late Animation<double> _currentSide;
  late Animation<double> _currentGoal;
  late Animation<double> _unitAnim;

  late NutrientEntity _oldGoal;
  late NutrientEntity _newGoal;

  @override
  void initState() {
    super.initState();
    _oldGoal = widget.focusedNutrient;
    _newGoal = widget.focusedNutrient;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _setupAnimations();
  }

  void _setupAnimations() {
    _progressAnim = Tween<double>(
      begin: _oldGoal.progress,
      end: _newGoal.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _currentMain = Tween<double>(
      begin: _oldGoal.current,
      end: _newGoal.current,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _currentSide = Tween<double>(
      begin: _oldGoal.target - _oldGoal.current,
      end: _newGoal.target - _newGoal.current,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _currentGoal = Tween<double>(
      begin: _oldGoal.target,
      end: _newGoal.target,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _unitAnim = Tween<double>(
      begin: _oldGoal.unit.length.toDouble(),
      end: _newGoal.unit.length.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didUpdateWidget(covariant OverviewSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.focusedNutrient.id != widget.focusedNutrient.id) {
      _oldGoal = oldWidget.focusedNutrient;
      _newGoal = widget.focusedNutrient;

      _setupAnimations();
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppSpacing.md,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: Tween(begin: 0.9, end: 1.0).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey(widget.focusedNutrient.id),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  widget.focusedNutrient.icon,
                  size: 22,
                ),
              ),
            ),

            Expanded(
              child: Text(
                widget.focusedNutrient.title,
                style: theme.textTheme.titleLarge,
              )
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: AnimatedBuilder(
                animation: _progressAnim,
                builder: (context, child) {
                  return Text(
                    "${(_progressAnim.value * 100).round()}%",
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  );
                },
              ),
            ),
          ],
        ),


        Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.sm,
              children: [
                AnimatedBuilder(
                  animation: _currentMain,
                  builder: (context, _) {
                    final current = _currentMain.value;
                    final target = _currentGoal.value;

                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: current.round().toString(),
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -2,
                              height: 1,
                            ),
                          ),
                          TextSpan(
                            text: " / ${target.round()} ${_newGoal.unit}",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white.withOpacity(0.45),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                AnimatedBuilder(
                  animation: _currentSide,
                  builder: (context, _) {
                    final current = _currentSide.value;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${current.round()}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.55),
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.2, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: AnimatedBuilder(
                              animation: _unitAnim,
                              builder: (context, _) {
                                final current = _unitAnim.value.round();

                                final newUnit = widget.focusedNutrient.unit;
                                final oldUnit = _oldGoal.unit;

                                final useOld = newUnit.trim().length < oldUnit.length && current > newUnit.trim().length;

                                final source = useOld ? oldUnit : newUnit;

                                final text = source.substring(0, current.clamp(0, source.length));

                                return Text(
                                  text,
                                  key: ValueKey(widget.focusedNutrient.unit),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.55),
                                  ),
                                );
                              }
                            ),
                          ),
                          Text(
                            (widget.dayOffset < 0) ? " übrig gehabt" : " übrig",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),



        AnimatedBuilder(
          animation: _progressAnim,
          builder: (context, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: LinearProgressIndicator(
                value: _progressAnim.value,
                minHeight: 7,
                color: const Color(0xFFFFB36B),
                backgroundColor: Colors.white.withOpacity(0.05),
              ),
            );
          },
        ),

        GoalSwitchBar(
          nutrients: widget.nutrients,
          focusedNutrient: widget.focusedNutrient,
          onSelect: widget.onGoalFocused,
        ),
      ],
    );
  }
}




