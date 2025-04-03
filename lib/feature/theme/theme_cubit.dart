import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});
}

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'theme';

  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.system)) {
    init();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode.name);

    emit(ThemeState(themeMode: themeMode));
  }

  /// Переключает между темной и светлой темой
  /// Если текущая тема системная или светлая, переключает на темную
  /// Если текущая тема темная, переключает на светлую
  Future<void> toggleTheme() async {
    final currentTheme = state.themeMode;
    final newTheme = currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newTheme);
  }

  void init() {
    getThemeMode().then((themeMode) {
      emit(ThemeState(themeMode: themeMode));
    });
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString(_themeKey);
    return ThemeMode.values.byName(themeMode ?? 'system');
  }
}
