import 'package:calentry/features/steps/presentation/widgets/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepsCard extends ConsumerWidget {
  final int goal;

  const StepsCard({
    super.key,
    this.goal = 10000,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepsAsync = ref.watch(
      stepsProvider(DateTime.now()),
    );

    return stepsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Text("Error: $e"),

      data: (steps) {
        final progress = (steps / goal).clamp(0.0, 1.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Steps",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Text(
              "$steps",
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "of $goal goal today",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.5),
              ),
            ),

            const SizedBox(height: 14),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
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