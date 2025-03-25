import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

extension ThemeExtension on BuildContext {
  AppThemeExtension get theme => AppTheme.themeExtension(this);

  ThemeData get themeOf => Theme.of(this);
}
