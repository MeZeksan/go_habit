part of 'app_theme.dart';

class _AppBarThemes {
  final light = AppBarTheme(
    color: _commonColors.lightSurface,
    surfaceTintColor: _commonColors.lightSurface,
    titleTextStyle: _commonTextStyles.headline3.copyWith(
      color: _commonColors.lightText,
    ),
  );

  final dark = AppBarTheme(
    color: _commonColors.darkSurface,
    surfaceTintColor: _commonColors.darkSurface,
    titleTextStyle: _commonTextStyles.headline3.copyWith(
      color: _commonColors.darkText,
    ),
  );
}
