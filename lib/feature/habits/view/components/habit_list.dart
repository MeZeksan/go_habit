import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/categories/bloc/habit_category_bloc.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:go_habit/feature/habits/view/components/habit_card.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habits;
  const HabitList({required this.habits, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitsBloc, HabitsState>(
      listenWhen: (previous, current) => previous is HabitsLoadSuccess,
      listener: (context, state) {
        if (state is HabitsOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.green,
          ));
        }

        if (state is HabitsOperationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<HabitCategoryBloc, HabitCategoryState>(
        builder: (context, state) {
          switch (state) {
            case HabitCategoryLoaded(:final categories) || HabitCategoryError(:final categories):
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return HabitCard(
                    habit: habits[index],
                    habitCategory: categories.singleWhere((element) => habits[index].categoryId == element.id,
                        orElse: () => HabitCategory(id: 'uknown', name: 'Общие', color: '#FFFF00')),
                  );
                },
              );
            case _:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
          }
        },
      ),
    );
  }
}
