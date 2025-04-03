import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/theme/theme_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    // Определяем текущую системную тему через PlatformDispatcher
    final platformDispatcher = View.of(context).platformDispatcher;
    final platformBrightness = platformDispatcher.platformBrightness;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        // Определяем текущий режим темы
        bool isDarkMode;

        if (state.themeMode == ThemeMode.dark) {
          isDarkMode = true;
        } else if (state.themeMode == ThemeMode.light) {
          isDarkMode = false;
        } else {
          // ThemeMode.system
          isDarkMode = platformBrightness == Brightness.dark;
        }

        return Switch(
          value: isDarkMode, //выводится значение темы
          onChanged: (_) {
            // Вызываем переключатель темы при изменении значения
            context.read<ThemeCubit>().toggleTheme();
          },
        );
      },
    );
  }
}
