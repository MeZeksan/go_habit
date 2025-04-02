import 'package:flutter/material.dart';
import 'package:go_habit/core/theme/app_theme.dart';

extension ThemeExtension on BuildContext {
  AppThemeExtension get theme => AppTheme.themeExtension(this);

  ThemeData get themeOf => Theme.of(this);
}
