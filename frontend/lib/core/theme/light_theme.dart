import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Lexend',
  colorScheme: const ColorScheme.light(
    primary: AppColors.purple,
    onPrimary: AppColors.textPrimary,
    secondary: AppColors.buttonSecondary,
    onSecondary: Colors.purple,
    surface: AppColors.backgroundWhite,
    onSurface: AppColors.textPrimary,
    error: AppColors.warning,
    onError: Colors.green,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.inputBorder,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.inputBorderFocus,
      ),
    ),
    hintStyle: TextStyle(
      fontSize: 14,
      color: AppColors.inputPlaceholder
    ),
  ),
  textTheme: const TextTheme(
    labelMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w600
    ),
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
  ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pink,
        foregroundColor: AppColors.textLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),



    useMaterial3: true
);