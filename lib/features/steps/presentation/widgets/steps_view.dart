import 'package:calentry/features/steps/presentation/widgets/providers.dart';
import 'package:calentry/features/steps/domain/entities/daily_step_stats.dart';
import 'package:calentry/features/water/presentation/providers/water_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StepsCard extends ConsumerStatefulWidget {
  final int dayOffset;

  const StepsCard({
    super.key,
    this.dayOffset = 0,
  });

  @override
  ConsumerState<StepsCard> createState() => _StepsCardState();
}

class _StepsCardState extends ConsumerState<StepsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<int> _countAnimation;

  int _displayedSteps = 0;
  int _displayedGoal = 10000;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _buildAnimations(from: 0, to: 0, goal: 10000);

    // Initialen Wert sofort setzen ohne Animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final current = ref.read(dailyStepsProvider(widget.dayOffset)).value;
      if (current != null) {
        _buildAnimations(from: 0, to: current.steps, goal: current.goal);
        _controller.forward(from: 0);
        _displayedSteps = current.steps;
        _displayedGoal = current.goal;
      }
    });
  }

  void _buildAnimations({
    required int from,
    required int to,
    required int goal,
  }) {
    _progressAnimation = Tween<double>(
      begin: (from / goal).clamp(0.0, 1.0),
      end: (to / goal).clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _countAnimation = IntTween(
      begin: from,
      end: to,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = dateForOffset(widget.dayOffset);

    ref.listen<AsyncValue<DailyStepStats>>(
      dailyStepsProvider(widget.dayOffset),
          (_, next) {
        final newSteps = next.value?.steps ?? 0;
        final newGoal = next.value?.goal ?? 10000;

        if (newSteps != _displayedSteps) {
          _buildAnimations(
            from: _displayedSteps,
            to: newSteps,
            goal: newGoal,
          );
          _controller.forward(from: 0);
          _displayedSteps = newSteps;
          _displayedGoal = newGoal;
        }
      },
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final goalLabel = _displayedGoal;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Schritte",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${(_progressAnimation.value * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              "${_countAnimation.value}",
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "von $goalLabel",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _progressAnimation.value,
                minHeight: 8,
                backgroundColor: Colors.white.withOpacity(0.08),
                valueColor: AlwaysStoppedAnimation(
                  Colors.greenAccent.withOpacity(0.9),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
