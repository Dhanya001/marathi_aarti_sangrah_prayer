import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'app_theme.dart';

// Enum to represent theme modes in storage
enum AppThemeMode { light, dark }

class ThemeCubit extends HydratedCubit<ThemeData> {
  ThemeCubit() : super(AppThemes.light);

  void setLightTheme() => emit(AppThemes.light);

  void setDarkTheme() => emit(AppThemes.dark);

  void toggleTheme() {
    state.brightness == Brightness.light
        ? emit(AppThemes.dark)
        : emit(AppThemes.light);
  }

  @override
  ThemeData? fromJson(Map<String, dynamic> json) {
    final themeStr = json['theme'] as String?;
    if (themeStr == 'dark') {
      return AppThemes.dark;
    }
    return AppThemes.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeData state) {
    return {'theme': state.brightness == Brightness.dark ? 'dark' : 'light'};
  }
}
