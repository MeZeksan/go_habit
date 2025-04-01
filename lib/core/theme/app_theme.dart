import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'animation_durations.dart';
part 'app_bar_theme.dart';
part 'app_theme_extension.dart';
part 'button_styles.dart';
part 'common_colors.dart';
part 'common_text_styles.dart';
part 'typography.dart';

const _commonColors = CommonColors();
const _typography = _Typography();
final _commonTextStyles = CommonTextStyles();
final _buttonStyles = _ButtonStyles();
final _appBarThemes = _AppBarThemes();
const _durations = AnimationDurations();

final _lightThemeData = ThemeData(
  appBarTheme: _appBarThemes.light,
  useMaterial3: true,
  primaryColor: _commonColors.lightPrimary,
  extensions: [
    AppThemeExtension.lightThemeExtension(),
  ],
  cardColor: _commonColors.lightSurface,
  elevatedButtonTheme: _buttonStyles.elevatedButtonThemeData,
  radioTheme: _buttonStyles.radioButtonTheme,
  textButtonTheme: _buttonStyles.textButtonThemeData,
  scaffoldBackgroundColor: _commonColors.lightBackground,
  floatingActionButtonTheme: _buttonStyles.floatingActionButtonTheme,
  dividerColor: _commonColors.lightDivider,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: _commonColors.lightText),
    bodyMedium: TextStyle(color: _commonColors.lightText),
    titleLarge: TextStyle(color: _commonColors.lightText),
  ),
);

final _darkThemeData = ThemeData(
  useMaterial3: true,
  primaryColor: _commonColors.darkPrimary,
  extensions: [
    AppThemeExtension.darkThemeExtension(),
  ],
  cardColor: _commonColors.darkSurface,
  elevatedButtonTheme: _buttonStyles.elevatedButtonThemeData,
  radioTheme: _buttonStyles.radioButtonTheme,
  scaffoldBackgroundColor: _commonColors.darkBackground,
  dividerColor: _commonColors.darkDivider,
  appBarTheme: _appBarThemes.dark,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: _commonColors.darkText),
    bodyMedium: TextStyle(color: _commonColors.darkText),
    titleLarge: TextStyle(color: _commonColors.darkText),
  ),
);

/// {@template app_theme}
/// An immutable class that holds properties needed
/// to build a [ThemeData] for the app.
/// {@endtemplate}
@immutable
final class AppTheme with Diagnosticable {
  /// {@macro app_theme}
  AppTheme({required this.themeMode, required this.seed})
      : darkTheme = _darkThemeData,
        lightTheme = _lightThemeData;

  /// The type of theme to use.
  final ThemeMode themeMode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seed;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme;

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme;

  /// The default [AppTheme].
  static final defaultTheme = AppTheme(
    themeMode: ThemeMode.system,
    seed: Colors.blue,
  );

  static AppThemeExtension themeExtension(BuildContext context) =>
      Theme.of(context).extension<AppThemeExtension>()!;

  /// The [ThemeData] for this [AppTheme].
  /// This is computed based on the [themeMode].
  ThemeData computeTheme() {
    switch (themeMode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('seed', seed));
    properties.add(EnumProperty<ThemeMode>('type', themeMode));
    properties.add(DiagnosticsProperty<ThemeData>('lightTheme', lightTheme));
    properties.add(DiagnosticsProperty<ThemeData>('darkTheme', darkTheme));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && seed == other.seed && themeMode == other.themeMode;

  @override
  int get hashCode => Object.hash(seed, themeMode);
}
