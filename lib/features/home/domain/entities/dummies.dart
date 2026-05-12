import 'package:flutter/material.dart';

import 'goal_entitiy.dart';

final goals = [
  GoalEntity(
    id: 'calories',
    title: 'Calories',
    shortLabel: 'kcal',
    current: 1842,
    target: 2400,
    unit: ' kcal',
    icon: Icons.local_fire_department_rounded,
  ),

  GoalEntity(
    id: 'protein',
    title: 'Protein',
    shortLabel: 'protein',
    current: 132,
    target: 180,
    unit: 'g',
    icon: Icons.fitness_center_rounded,
  ),

  GoalEntity(
    id: 'carbs',
    title: 'Carbs',
    shortLabel: 'carbs',
    current: 210,
    target: 260,
    unit: 'g',
    icon: Icons.grain_rounded,
  ),

  GoalEntity(
    id: 'fat',
    title: 'Fat',
    shortLabel: 'fat',
    current: 58,
    target: 70,
    unit: 'g',
    icon: Icons.opacity_rounded,
  ),
];