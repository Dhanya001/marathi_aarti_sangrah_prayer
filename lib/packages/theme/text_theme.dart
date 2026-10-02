import 'package:flutter/material.dart';
import 'package:infocontract/packages/theme/app_colors.dart';
import 'app_text_styles.dart';

class AppTextTheme {
  static TextTheme light = TextTheme(
    displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.primaryText),
    displayMedium: AppTextStyles.displayMedium.copyWith(
      color: AppColors.primaryText,
    ),
    displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.primaryText),
    headlineLarge: AppTextStyles.headlineLarge.copyWith(
      color: AppColors.primaryText,
    ),
    headlineMedium: AppTextStyles.headlineMedium.copyWith(
      color: AppColors.primaryText,
    ),
    headlineSmall: AppTextStyles.headlineSmall.copyWith(
      color: AppColors.primaryText,
    ),
    titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.primaryText),
    titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.primaryText),
    titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.primaryText),
    bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.primaryText),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryText),
    bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryText),
    labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.primaryText),
    labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.primaryText),
    labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.primaryText),
  );

  static TextTheme dark = light.copyWith(
    displayLarge: AppTextStyles.displayLarge.copyWith(
      color: AppColors.primaryDark,
    ),
    displayMedium: AppTextStyles.displayMedium.copyWith(
      color: AppColors.primaryDark,
    ),
    displaySmall: AppTextStyles.displaySmall.copyWith(
      color: AppColors.primaryDark,
    ),
    headlineLarge: AppTextStyles.headlineLarge.copyWith(
      color: AppColors.primaryDark,
    ),
    headlineMedium: AppTextStyles.headlineMedium.copyWith(
      color: AppColors.primaryDark,
    ),
    headlineSmall: AppTextStyles.headlineSmall.copyWith(
      color: AppColors.primaryDark,
    ),
    titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.primaryDark),
    titleMedium: AppTextStyles.titleMedium.copyWith(
      color: AppColors.primaryDark,
    ),
    titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.primaryDark),
    bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.primaryDark),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryDark),
    bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryDark),
    labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.primaryDark),
    labelMedium: AppTextStyles.labelMedium.copyWith(
      color: AppColors.primaryDark,
    ),
    labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.primaryDark),
  );
}
