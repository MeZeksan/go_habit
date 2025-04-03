part of 'app_theme.dart';

class _AppBarThemes {
  final light = AppBarTheme(
    color: _commonColors.lightBackground,
    surfaceTintColor: _commonColors.lightBackground,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: _commonColors.lightPrimaryText,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: _typography.tbcxMediumFont,
    ),
    iconTheme: IconThemeData(color: _commonColors.lightPrimaryText),
    actionsIconTheme: IconThemeData(color: _commonColors.lightPrimaryText),
  );

  final dark = AppBarTheme(
    color: _commonColors.darkBackground,
    surfaceTintColor: _commonColors.darkBackground,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: _commonColors.darkPrimaryText,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: _typography.tbcxMediumFont,
    ),
    iconTheme: IconThemeData(color: _commonColors.darkPrimaryText),
    actionsIconTheme: IconThemeData(color: _commonColors.darkPrimaryText),
  );
}
