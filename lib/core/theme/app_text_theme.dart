import 'package:flutter/material.dart';

TextTheme buildTextTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 42,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.4,
      color: isDark ? Colors.white : Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.8,
      color: isDark ? Colors.white : Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 1.4,
      fontWeight: FontWeight.w500,
      color: isDark ? Colors.white : Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.4,
      fontWeight: FontWeight.w500,
      color: isDark ? Colors.white70 : Colors.black87,
    ),
  );
}