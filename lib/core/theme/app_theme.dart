import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: buildTextTheme(Brightness.light),
      splashFactory: NoSplash.splashFactory,
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: buildTextTheme(Brightness.dark),
      splashFactory: NoSplash.splashFactory,
      useMaterial3: true,
    );
  }
}