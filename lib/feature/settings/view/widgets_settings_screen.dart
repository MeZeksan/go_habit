import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/extension/locale_extension.dart';
import 'package:go_habit/feature/home/bloc/habit_card_settings_bloc.dart';
import 'package:go_habit/feature/home/view/components/habit_card_type_selector.dart';

class WidgetsSettingsScreen extends StatelessWidget {
  const WidgetsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.widgets),
      ),
      body: BlocBuilder<HabitCardSettingsBloc, HabitCardSettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Настройки карточек',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                HabitCardTypeSelector(
                  selectedMode: state.displayMode,
                  onModeSelected: (mode) {
                    context.read<HabitCardSettingsBloc>().add(
                          UpdateHabitCardDisplayMode(mode),
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
