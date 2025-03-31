import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/domain/bloc/auth_bloc.dart';
import '../bloc/habits_bloc.dart';
import 'components/habit_list.dart';
import 'components/modal_bottom_sheet.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Habit'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              context.read<AuthBloc>().add(
                    AuthLogoutButtonPressed(),
                  );
            },
          ),
          const SizedBox(width: 8),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  useRootNavigator: true,
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (_) => const AddHabitBottomSheet(),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<HabitsBloc, HabitsState>(builder: (context, state) {
        return switch (state) {
          HabitsInitial() => const Center(child: CircularProgressIndicator.adaptive()),
          HabitsLoading() => const Center(child: CircularProgressIndicator.adaptive()),
          HabitsLoadSuccess(habits: final habits) => HabitList(habits: habits),
          HabitsOperationSuccess(habits: final habits) ||
          HabitsOperationFailure(habits: final habits) =>
            HabitList(habits: habits),
        };
      }),
    );
  }
}
