import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/common/constants/shared_preferences_keys.dart';

import '/common/theme/app_theme.dart';

class ThemesCubit extends Cubit<ThemeData> {
  final SharedPreferences sharedPreferences;

  ThemesCubit(
    this.sharedPreferences,
  ) : super(AppTheme.lightTheme) {
    _getThemeFromPrefs();
  }

  Future<void> _saveThemeToPrefs({required Brightness brightness}) async {
    final themeIndex = brightness == Brightness.light ? 0 : 1;
    await sharedPreferences.setInt(SharedPreferencesKeys.theme, themeIndex);
  }

  Future<void> _getThemeFromPrefs() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final savedThemeIndex =
        sharedPreferences.getInt(SharedPreferencesKeys.theme) ?? 0;
    final savedTheme =
        savedThemeIndex == 0 ? AppTheme.lightTheme : AppTheme.darkTheme;
    emit(savedTheme);
  }

  void toggleTheme() {
    emit(
      state.brightness == Brightness.light
          ? AppTheme.darkTheme
          : AppTheme.lightTheme,
    );
    _saveThemeToPrefs(brightness: state.brightness);
  }
}
