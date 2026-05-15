import 'package:flutter/material.dart';

import 'nutrient_entitiy.dart';

final nutrients = [
  NutrientEntity(
    id: 'calories',
    title: 'Kalorien',
    shortLabel: 'kcal',
    current: 1842,
    target: 2400,
    unit: ' kcal',
    icon: Icons.local_fire_department_rounded,
  ),

  NutrientEntity(
    id: 'protein',
    title: 'Protein',
    shortLabel: 'protein',
    current: 132,
    target: 180,
    unit: 'g',
    icon: Icons.fitness_center_rounded,
  ),

  NutrientEntity(
    id: 'carbs',
    title: 'Carbs',
    shortLabel: 'carbs',
    current: 210,
    target: 260,
    unit: 'g',
    icon: Icons.grain_rounded,
  ),

  NutrientEntity(
    id: 'fat',
    title: 'Fett',
    shortLabel: 'Fett',
    current: 58,
    target: 70,
    unit: 'g',
    icon: Icons.opacity_rounded,
  ),
];