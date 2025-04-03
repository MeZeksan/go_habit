import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/categories/bloc/habit_category_bloc.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:go_habit/feature/home/bloc/habit_card_settings_bloc.dart';
import 'package:go_habit/feature/home/view/components/habit_home_card.dart';

class HabitHomeList extends StatelessWidget {
  const HabitHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        if (state is HabitsLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final habits = state.habits;

        return SliverList(
          delegate: SliverChildListDelegate(
            habits.map((habit) {
              return BlocBuilder<HabitCategoryBloc, HabitCategoryState>(
                builder: (context, categoryState) {
                  if (categoryState is HabitCategoryLoaded) {
                    final category = categoryState.categories.firstWhere((c) => c.id == habit.categoryId);
                    return BlocBuilder<HabitCardSettingsBloc, HabitCardSettingsState>(
                      builder: (context, settingsState) {
                        return HabitHomeCard(
                          habit: habit,
                          category: category,
                          displayMode: HabitCardDisplayMode.values[settingsState.displayMode.index],
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
