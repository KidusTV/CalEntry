import 'package:calentry/features/steps/presentation/widgets/providers.dart';
import 'package:calentry/features/steps/domain/entities/daily_step_stats.dart';
import 'package:calentry/features/water/presentation/providers/water_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepsCard extends ConsumerWidget {
  final int dayOffset;

  const StepsCard({
    super.key,
    this.dayOffset = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = dateForOffset(dayOffset);
    final stepsAsync = ref.watch(dailyStepsProvider(dayOffset));

    // Wir nutzen valueOrNull, um "Zero-Loading" zu erreichen.
    // Falls noch geladen wird oder ein Fehler vorliegt, nehmen wir ein leeres Stats-Objekt.
    final stats = stepsAsync.value ?? DailyStepStats(
      day: date,
      steps: 0,
      goal: 10000,
      updatedAt: DateTime.now(),
    );

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
              "${(stats.progress * 100).toInt()}%",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          "${stats.steps}",
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "of ${stats.goal} goal today",
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: stats.progress,
            minHeight: 8,
            backgroundColor: Colors.white.withOpacity(0.08),
            valueColor: AlwaysStoppedAnimation(
              Colors.greenAccent.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }
}
