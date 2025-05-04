import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: AppColors.pink,
    onPrimary: Colors.white,
    secondary: AppColors.buttonSecondary,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: AppColors.textPrimary,
    error: AppColors.warning,
    onError: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
  ),
  useMaterial3: true
);