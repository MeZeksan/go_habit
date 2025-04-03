import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/theme/theme_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        // Определяем текущий режим темы
        final isDarkMode = state.themeMode == ThemeMode.dark ||
            (state.themeMode == ThemeMode.system &&
                Theme.of(context).brightness == Brightness.dark);

        return Switch(
          value: isDarkMode,
          onChanged: (_) {
            // Вызываем переключатель темы при изменении значения
            context.read<ThemeCubit>().toggleTheme();
          },
        );
      },
    );
  }
}
