import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/goal_entitiy.dart';


class OverviewSection extends StatefulWidget {
  final GoalEntity focusedGoal;
  final List<GoalEntity> goals;
  final ValueChanged<GoalEntity> onGoalFocused;

  const OverviewSection({
    super.key,
    required this.focusedGoal,
    required this.goals,
    required this.onGoalFocused,
  });

  @override
  State<OverviewSection> createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _progressAnim;
  late Animation<double> _currentMain;
  late Animation<double> _currentSide;
  late Animation<double> _currentGoal;
  late Animation<double> _unitAnim;

  late GoalEntity _oldGoal;
  late GoalEntity _newGoal;

  @override
  void initState() {
    super.initState();
    _oldGoal = widget.focusedGoal;
    _newGoal = widget.focusedGoal;

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

    if (oldWidget.focusedGoal.id != widget.focusedGoal.id) {
      _oldGoal = oldWidget.focusedGoal;
      _newGoal = widget.focusedGoal;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                key: ValueKey(widget.focusedGoal.id),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  widget.focusedGoal.icon,
                  size: 22,
                ),
              ),
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

        const SizedBox(height: 28),

        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                Text(
                  widget.focusedGoal.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

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

                                String text;
                                if (widget.focusedGoal.unit.length == 1) {
                                  if (current != 1) {
                                    text = _oldGoal.unit.substring(0, current.clamp(0, _oldGoal.unit.length));
                                  } else {
                                    text = widget.focusedGoal.unit;
                                  }
                                }
                                return Text(
                                  widget.focusedGoal.unit.substring(0, current.clamp(0, widget.focusedGoal.unit.length)),
                                  key: ValueKey(widget.focusedGoal.unit),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.55),
                                  ),
                                );
                              }
                            ),
                          ),
                          Text(
                            " remaining today",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.55),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

          ],
        ),

        const SizedBox(height: AppSpacing.lg),

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

        const SizedBox(height: AppSpacing.lg),

        GoalSwitchBar(
          goals: widget.goals,
          focusedGoal: widget.focusedGoal,
          onSelect: widget.onGoalFocused,
        ),
      ],
    );
  }
}



class GoalSwitchBar extends StatelessWidget {
  final List<GoalEntity> goals;
  final GoalEntity focusedGoal;
  final ValueChanged<GoalEntity> onSelect;

  const GoalSwitchBar({
    super.key,
    required this.goals,
    required this.focusedGoal,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: goals.map((goal) {
        final isActive = goal.id == focusedGoal.id;
        return GoalSwichBar(onSelect: onSelect, isActive: isActive, goal: goal);
      }).toList(),
    );
  }
}

class GoalSwichBar extends StatelessWidget {
  const GoalSwichBar({
    super.key,
    required this.goal,
    required this.onSelect,
    required this.isActive,
  });

  final GoalEntity goal;
  final ValueChanged<GoalEntity> onSelect;
  final bool isActive;

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: isActive ? goal.progress : 0,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, _) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0,
            end: isActive ? 0 : goal.progress,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          builder: (context, animProgress, _) {
            return GestureDetector(
              onTap: () => onSelect(goal),
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
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedFractionallySizedBox(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                              heightFactor: 1,
                              widthFactor: animProgress.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFB36B).withOpacity(0.70),

                                  borderRadius: BorderRadius.circular(AppRadius.sm),

                                ),
                              ),
                            ),
                          ),
                        ),

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
                                  ? const Color(0xFFFFB36B)
                                  : Colors.white.withOpacity(0.05),
                            ),
                          ),
                          child: Text(
                            goal.shortLabel,
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



class _ProgressBorderPainter extends CustomPainter {
  final double progress;
  final bool isActive;

  _ProgressBorderPainter({
    required this.progress,
    required this.isActive,
  });

  @override
  void paint(Canvas canvas, Size size) {

    // PROGRESS BORDER (arc effect)
    final progressPaint = Paint()
      ..color = isActive ? Color(0xFFFFB36B): Color(0xFFFF7D54)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isActive ? 1.6 : 1.2
      ..strokeCap = StrokeCap.round;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(999),
    );

    // Startpunkt verschieben (Rotation des Pfads)
    final path = Path()
      ..addRRect(rrect)
      ..transform(Matrix4.rotationZ(-math.pi / 2).storage);

    final metrics = path.computeMetrics().first;

    final totalLength = metrics.length;
    final startOffset = totalLength * 0.75;
    final drawLength = totalLength * progress;

    final endOffset = startOffset + drawLength;

    Path extractPath;

    if (endOffset <= totalLength) {
      extractPath = metrics.extractPath(
        startOffset,
        endOffset,
      );
    } else {
      extractPath = Path()
        ..addPath(
          metrics.extractPath(startOffset, totalLength),
          Offset.zero,
        )
        ..addPath(
          metrics.extractPath(0, endOffset - totalLength),
          Offset.zero,
        );
    }

    canvas.drawPath(extractPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _ProgressBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isActive != isActive;
  }
}