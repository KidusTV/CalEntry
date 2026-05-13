import 'package:calentry/features/home/domain/entities/dummies.dart';
import 'package:calentry/features/home/presentation/widgets/home_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/scroll_custom_view.dart';
import '../../../steps/presentation/widgets/steps_view.dart';
import '../../../water/presentation/widgets/water_input_card/water_input_card.dart';
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
      padding: padding.copyWith(top: padding.top + AppSpacing.md, bottom: padding.bottom + AppSpacing.md * 2),
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
          child: HomeItem(child: WaterInputCard(
              dayOffset: widget.dayOffset
          )),
        ),
        // SliverToBoxAdapter(
        //   child: HomeItem(child: StepsCard(goal: 10000)),
        // )
      ],
    );
  }
}