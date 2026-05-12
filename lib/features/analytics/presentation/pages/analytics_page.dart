import 'package:flutter/material.dart';

import '../../../../core/widgets/premium_scaffold.dart';
import '../widgets/analytics_header.dart';
import '../widgets/calorie_trend_chart.dart';
import '../widgets/streak_card.dart';
import '../widgets/weekly_heatmap.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumScaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                AnalyticsHeader(),
                SizedBox(height: 24),
                StreakCard(),
                SizedBox(height: 24),
                WeeklyHeatmap(),
                SizedBox(height: 24),
                CalorieTrendChart(),
                SizedBox(height: 180),
              ],
            ),
          ),
        ],
      ),
    );
  }
}