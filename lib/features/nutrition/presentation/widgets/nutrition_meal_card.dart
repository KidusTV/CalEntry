import 'package:flutter/material.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/meal_type.dart';

class NutritionMealCard extends StatefulWidget {
  final MealType mealType;
  final int dayOffset;

  const NutritionMealCard({
    super.key,
    required this.mealType,
    required this.dayOffset,
  });

  @override
  State<NutritionMealCard> createState() => _NutritionMealCardState();
}

class _NutritionMealCardState extends State<NutritionMealCard>
    with SingleTickerProviderStateMixin {
  bool expanded = false;

  final Map<String, List<String>> _foodsByKey = {};

  String get _key => '${widget.dayOffset}_${widget.mealType.name}';

  List<String> get foods => _foodsByKey[_key] ?? [];

  void addFood(String food) {
    setState(() {
      final list = _foodsByKey[_key] ?? [];
      list.add(food);
      _foodsByKey[_key] = list;
    });
  }

  void removeFood(String food) {
    setState(() {
      final list = _foodsByKey[_key] ?? [];
      list.remove(food);
      _foodsByKey[_key] = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.mealType.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    turns: expanded ? 0 : -0.25,
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),

            if (expanded) ...[
              const SizedBox(height: 18),

              const _FoodTile(),

              const SizedBox(height: 12),

              const _FoodTile(),

              const SizedBox(height: 16),

              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.10),
                        Colors.white.withValues(alpha: 0.04),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Lebensmittel hinzufügen',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FoodTile extends StatefulWidget {
  const _FoodTile();

  @override
  State<_FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<_FoodTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  double scale = 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.96,
      upperBound: 1,
      value: 1,
    )..addListener(() {
      setState(() {
        scale = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.reverse();
      },
      onTapUp: (_) {
        _controller.forward();
      },
      onTapCancel: () {
        _controller.forward();
      },
      child: Transform.scale(
        scale: scale,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.04),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.02),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.restaurant_rounded,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Protein Pudding',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '220 kcal • 20g Protein • 8g Zucker',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.white.withValues(alpha: 0.06),
                ),
                child: const Text(
                  '250g',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}