import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/premium_scaffold.dart';
import '../../../../core/widgets/scroll_custom_view.dart';
import '../widgets/analytics_header.dart';
import '../widgets/calorie_trend_chart.dart';
import '../widgets/streak_card.dart';
import '../widgets/weekly_heatmap.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.paddingOf(context).copyWith(right: 0, left: 0);

    return ScrollCustomView(
      padding: padding.copyWith(top: padding.top + AppSpacing.md, bottom: padding.bottom + AppSpacing.md * 2),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: AppSpacing.lg,
            children: [
              AnalyticsHeader(),
              StreakCard(),
              WeeklyHeatmap(),
              CalorieTrendChart(),
            ],
          ),
        ),
      ],
    );
  }
}