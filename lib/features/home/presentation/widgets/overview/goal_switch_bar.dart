import 'package:flutter/material.dart';

import '../../../domain/entities/nutrient_entitiy.dart';
import 'goal_bar_item.dart';

class GoalSwitchBar extends StatelessWidget {
  final List<NutrientEntity> nutrients;
  final NutrientEntity focusedNutrient;
  final ValueChanged<NutrientEntity> onSelect;

  const GoalSwitchBar({
    super.key,
    required this.nutrients,
    required this.focusedNutrient,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: nutrients.map((nutrient) {
        final isActive = nutrient.id == focusedNutrient.id;
        return GoalBarItem(onSelect: onSelect, isActive: isActive, nutrient: nutrient);
      }).toList(),
    );
  }
}
