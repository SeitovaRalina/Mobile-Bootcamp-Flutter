import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = _prefs.getString('theme_mode');
    if (savedTheme != null) {
      emit(_parseThemeMode(savedTheme));
    }
  }

  void updateTheme(ThemeMode mode) {
    _prefs.setString('theme_mode', mode.toString());
    emit(mode);
  }

  ThemeMode _parseThemeMode(String str) {
    return ThemeMode.values.firstWhere(
      (e) => e.toString() == str,
      orElse: () => ThemeMode.system,
    );
  }
}
