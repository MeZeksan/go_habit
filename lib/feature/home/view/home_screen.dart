import 'package:flutter/material.dart';
import 'package:go_habit/feature/home/widget/habit_home_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            title: const Text(
              'Go Habit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 300.0, bottom: 120.0),
            sliver: HabitHomeList(),
          ),
        ],
      ),
    );
  }
}
