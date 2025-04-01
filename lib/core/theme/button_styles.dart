part of 'app_theme.dart';

class _ButtonStyles {
  final elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _commonColors.lightPrimary,
      foregroundColor: _commonColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size.fromHeight(44),
      maximumSize: const Size.fromHeight(44),
      textStyle: _commonTextStyles.label,
      elevation: 0,
    ),
  );
  final textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: _commonTextStyles.body,
      foregroundColor: _commonColors.lightPrimary,
    ),
  );

  final radioButtonTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return _commonColors.lightPrimary;
      }
      return _commonColors.lightSecondary;
    }),
  );

  final floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: _commonColors.lightPrimary,
    foregroundColor: _commonColors.white,
    elevation: 1,
  );
}
