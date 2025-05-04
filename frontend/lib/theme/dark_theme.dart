import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.purple,
    onPrimary: Colors.white,
    secondary: AppColors.buttonSecondary,
    onSecondary: Colors.black,
    surface: AppColors.textSecondary,
    onSurface: AppColors.textLight,
    error: AppColors.warning,
    onError: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textLight),
    bodyMedium: TextStyle(color: AppColors.textTertiary),
  ),
  useMaterial3: true
);