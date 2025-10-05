import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Configura o tema claro da aplicação, com base em `ThemeData`, para ambientes com alta luminosidade.

ThemeData lightTheme = ThemeData(
    dividerColor: AppColors.inputBorder,
    brightness: Brightness.light,
    fontFamily: 'Lexend',
    colorScheme: const ColorScheme.light(
      primary: AppColors.purple,
      onPrimary: AppColors.textLight,
      secondary: AppColors.pink,
      onSecondary: AppColors.textLight,
      surface: AppColors.backgroundSmoke,
      surfaceBright: AppColors.backgroundWhite,
      onSurface: AppColors.textPrimary,
      error: AppColors.warning,
      onError: AppColors.textPrimary,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.inputBackground,
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 12,
        height: 1.5,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.inputBorder,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.inputBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.purple,
        ),
      ),
      hintStyle: TextStyle(fontSize: 14, color: AppColors.inputPlaceholder),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.warning,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.inputBorderDisabled,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700),
      labelSmall: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
      ),
      labelMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        visualDensity: VisualDensity.comfortable,
        backgroundColor: AppColors.purple,
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
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.resolveWith<Color>((states) {
          // if (states.contains(WidgetState.pressed)) {
          //   return AppColors.textSecondary; // cor quando pressionado
          // }

          return AppColors.inputPlaceholder; // cor padrão
        }),
      ),
    ),
    useMaterial3: true);
