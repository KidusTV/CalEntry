// steps_progress_widget.dart
import 'package:flutter/material.dart';

class StepsProgressWidget extends StatefulWidget {
  final int steps;
  final int goal;

  const StepsProgressWidget({
    super.key,
    required this.steps,
    required this.goal,
  });

  @override
  State<StepsProgressWidget> createState() => _StepsProgressWidgetState();
}

class _StepsProgressWidgetState extends State<StepsProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<int> _countAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _buildAnimations(from: 0);
    _controller.forward();
  }

  @override
  void didUpdateWidget(StepsProgressWidget old) {
    super.didUpdateWidget(old);
    if (old.steps != widget.steps) {
      _buildAnimations(from: old.steps);
      _controller.forward(from: 0);
    }
  }

  void _buildAnimations({required int from}) {
    final targetProgress = (widget.steps / widget.goal).clamp(0.0, 1.0);
    final fromProgress = (from / widget.goal).clamp(0.0, 1.0);

    _progressAnimation = Tween<double>(
      begin: fromProgress,
      end: targetProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _countAnimation = IntTween(
      begin: from,
      end: widget.steps,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          children: [
            Text(
              '${_countAnimation.value}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: _progressAnimation.value,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      },
    );
  }
}