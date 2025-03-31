import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

import '../../bloc/habits_bloc.dart';
import 'habit_card.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habits;
  const HabitList({super.key, required this.habits});

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
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HabitCard(habit: habits[index]);
        },
      ),
    );
  }
}
