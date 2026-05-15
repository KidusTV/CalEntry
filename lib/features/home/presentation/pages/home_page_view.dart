import 'package:calentry/features/home/domain/entities/dummies.dart';
import 'package:calentry/features/home/presentation/widgets/home_item.dart';
import 'package:calentry/features/nutrition/presentation/widgets/meal_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/scroll_custom_view.dart';
import '../../../steps/presentation/widgets/steps_view.dart';
import '../../../water/presentation/widgets/water_input_card/water_input_card.dart';
import '../../domain/entities/nutrient_entitiy.dart';
import '../widgets/overview/overview_section.dart';

class HomePageView extends StatefulWidget {
  final int dayOffset;
  final String title;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final void Function(int) toOffset;

  const HomePageView({
    super.key,
    required this.dayOffset,
    required this.title,
    required this.onNext,
    required this.onPrevious,
    required this.toOffset,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late NutrientEntity focusedNutrient;

  @override
  void initState() {
    super.initState();
    focusedNutrient = nutrients.first;
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.paddingOf(context).copyWith(right: 0, left: 0);

    return ScrollCustomView(
      padding: padding.copyWith(
        top: 0, // Padding wird jetzt von der SliverAppBar behandelt
        bottom: padding.bottom + AppSpacing.md * 2,
      ),
      slivers: [
        // Die neue SliverAppBar
        SliverCustomAppBar(
          title: widget.title,
          previous: widget.onPrevious,
          next: widget.onNext,
          toOffset: widget.toOffset,
        ),

        SliverToBoxAdapter(
          child: HomeItem(
            child: OverviewSection(
              dayOffset: widget.dayOffset,
              focusedNutrient: focusedNutrient,
              nutrients: nutrients,
              onGoalFocused: (nutrient) {
                setState(() {
                  HapticFeedback.lightImpact();
                  focusedNutrient = nutrient;
                });
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: HomeItem(child: MealOverviewCard(
            consumedCalories: 0,
            targetCalories: 0,
            breakfastCalories: 0,
            lunchCalories: 0,
            dinnerCalories: 0,
            snackCalories: 0,
            onTap: () {},
          )),
        ),
        SliverToBoxAdapter(
          child: HomeItem(
            child: WaterInputCard(dayOffset: widget.dayOffset),
          ),
        ),
        SliverToBoxAdapter(
          child: HomeItem(
            child: StepsCard(dayOffset: widget.dayOffset),
          ),
        ),
      ],
    );
  }
}
