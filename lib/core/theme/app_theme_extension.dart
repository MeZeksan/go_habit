part of 'app_theme.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final CommonColors commonColors;
  final CommonTextStyles commonTextStyles;
  final AnimationDurations durations;

  const AppThemeExtension({
    required this.commonColors,
    required this.commonTextStyles,
    required this.durations,
  });

  factory AppThemeExtension.lightThemeExtension() => AppThemeExtension(
        commonColors: _commonColors,
        commonTextStyles: _commonTextStyles,
        durations: _durations,
      );

  factory AppThemeExtension.darkThemeExtension() => AppThemeExtension(
        commonColors: _commonColors,
        commonTextStyles: _commonTextStyles,
        durations: _durations,
      );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    CommonColors? commonColors,
    CommonTextStyles? commonTextStyles,
    AnimationDurations? durations,
  }) =>
      AppThemeExtension(
        commonColors: commonColors ?? this.commonColors,
        commonTextStyles: commonTextStyles ?? this.commonTextStyles,
        durations: durations ?? this.durations,
      );

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) =>
      AppThemeExtension(
        commonColors: commonColors,
        commonTextStyles: commonTextStyles,
        durations: durations,
      );
}
