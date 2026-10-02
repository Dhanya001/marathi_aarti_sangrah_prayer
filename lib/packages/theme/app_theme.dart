import 'package:flutter/material.dart';
import 'package:infocontract/core/constants/assets/fonts.gen.dart';
import 'package:infocontract/packages/theme/text_theme.dart';
import 'app_colors.dart';

class AppThemes {
  static final ThemeData light = ThemeData(
    fontFamily: FontFamily.outfit,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryFixed: AppColors.primaryText,
      secondary: AppColors.grayLight,
      error: AppColors.error,
      onSurface: AppColors.backgroundDark,
      outline: AppColors.outline,

    ),
    textTheme: AppTextTheme.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.secondary,
      titleTextStyle: AppTextTheme.light.titleMedium?.copyWith(
        color: AppColors.primaryText,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.primary,
      surfaceTintColor: AppColors.grayLight,

      headerBackgroundColor: AppColors.primary,
      headerForegroundColor: AppColors.secondary,
      headerHelpStyle: const TextStyle(color: AppColors.secondary),
      headerHeadlineStyle: const TextStyle(
        color: AppColors.secondary,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return Colors.grey.shade400;
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.secondary;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.secondary;
        return AppColors.transparent;
      }),
      weekdayStyle: const TextStyle(color: AppColors.secondary),

      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.secondary;
      }),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.secondary;
        return AppColors.transparent;
      }),

      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.secondary),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        backgroundColor: WidgetStateProperty.all(AppColors.secondary),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    fontFamily: FontFamily.outfit,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      primaryFixed: AppColors.primaryTextDark,
      secondary: AppColors.secondaryDark,
      error: AppColors.error,
      onSurface: AppColors.background,
      outline: AppColors.outlineDark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondaryDark,
      foregroundColor: AppColors.primaryDark,
      titleTextStyle: AppTextTheme.dark.titleMedium,
    ),
    textTheme: AppTextTheme.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondaryDark,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.primary,
      surfaceTintColor: AppColors.grayLight,

      headerBackgroundColor: AppColors.primary,
      headerForegroundColor: AppColors.secondary,
      headerHelpStyle: const TextStyle(color: AppColors.secondary),
      headerHeadlineStyle: const TextStyle(
        color: AppColors.secondary,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return Colors.grey.shade400;
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.secondary;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.secondary;
        return AppColors.transparent;
      }),
      weekdayStyle: const TextStyle(color: AppColors.secondary),

      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.secondary;
      }),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.secondary;
        return AppColors.transparent;
      }),

      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.secondary),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        backgroundColor: WidgetStateProperty.all(AppColors.secondary),
      ),
    ),
  );
}
