import 'package:flutter/material.dart' as material;
import 'package:go_habit/feature/theme/theme_cubit.dart';

/// Расширение для преобразования типов ThemeMode
extension ThemeModeExtension on ThemeMode {
  /// Конвертирует ThemeMode из кубита в ThemeMode из Flutter
  material.ThemeMode toMaterialThemeMode() {
    switch (this) {
      case ThemeMode.light:
        return material.ThemeMode.light;
      case ThemeMode.dark:
        return material.ThemeMode.dark;
      case ThemeMode.system:
        return material.ThemeMode.system;
    }
  }
}
