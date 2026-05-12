import 'package:calentry/features/home/domain/entities/dummies.dart';
import 'package:calentry/features/home/presentation/widgets/home_item.dart';
import 'package:calentry/features/water/presentation/widgets/water_input_section.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/ScrollCustomView.dart';
import '../../domain/entities/goal_entitiy.dart';
import 'overview_section.dart';

class HomePageView extends StatefulWidget {
  final int dayOffset;

  const HomePageView({
    super.key,
    required this.dayOffset,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late GoalEntity focusedGoal;

  @override
  void initState() {
    super.initState();

    focusedGoal = goals.first;
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.paddingOf(context).copyWith(right: 0, left: 0);
    return ScrollCustomView(
      padding: padding.copyWith(top: padding.top + AppSpacing.md),
      slivers: [
        SliverToBoxAdapter(
          child: HomeItem(
            child: OverviewSection(
              focusedGoal: focusedGoal,
              goals: goals,
              onGoalFocused: (goal) {
                setState(() {
                  focusedGoal = goal;
                });
              },
            )
          ),
        ),
        SliverToBoxAdapter(
          child: HomeItem(child: WaterInputCard()),
        ),
      ],
    );
  }
}