import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Configura o tema claro da aplicação, com base em `ThemeData`, para ambientes com alta luminosidade.

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Lexend',
    colorScheme: const ColorScheme.light(
      primary: AppColors.purple,
      onPrimary: AppColors.textLight,
      secondary: AppColors.purple,
      onSecondary: AppColors.textLight,
      surface: AppColors.backgroundSmoke,
      surfaceBright: AppColors.backgroundWhite,
      onSurface: AppColors.textPrimary,
      error: AppColors.warning,
      onError: AppColors.textPrimary,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.inputBorder,
        ),
      ),
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
      hintStyle: TextStyle(fontSize: 14, color: AppColors.inputPlaceholder),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.warning,
        ),
      ),
    ),
    textTheme: const TextTheme(
      labelMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium:
          TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w400),
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
    iconTheme: const IconThemeData(
      color: AppColors.textSecondary,
      size: 24,
    ),
    useMaterial3: true);
