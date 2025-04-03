import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:go_habit/feature/categories/bloc/habit_category_bloc.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

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

        return BlocBuilder<HabitCategoryBloc, HabitCategoryState>(
          builder: (context, categoryState) {
            switch (categoryState) {
              case HabitCategoryLoaded(:final categories) ||
                    HabitCategoryError(:final categories):
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final habit = habits[index];
                      return _HabitListItem(
                        habit: habit,
                        category: categories.singleWhere(
                          (element) => habit.categoryId == element.id,
                          orElse: () => HabitCategory(
                            id: 'unknown',
                            name: 'Общие',
                            color: '#FFFF00',
                          ),
                        ),
                      );
                    },
                    childCount: habits.length,
                  ),
                );
              case _:
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
            }
          },
        );
      },
    );
  }
}

class _HabitListItem extends StatefulWidget {
  final Habit habit;
  final HabitCategory category;

  const _HabitListItem({
    required this.habit,
    required this.category,
  });

  @override
  State<_HabitListItem> createState() => _HabitListItemState();
}

class _HabitListItemState extends State<_HabitListItem> {
  double _progress = 0.0;

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  IconData _getCategoryIcon(String categoryId, HabitCategoryState state) {
    if (state is HabitCategoryError) {
      switch (categoryId) {
        case 'art':
          return Icons.brush;
        case 'education':
          return Icons.school;
        case 'health':
          return Icons.fitness_center;
        case 'money':
          return Icons.attach_money;
        case 'selv-development':
          return Icons.self_improvement;
        case 'sport':
          return Icons.sports_soccer;
        case 'work':
          return Icons.work;
        default:
          return Icons.category;
      }
    }
    return Icons.category;
  }

  void _completeHabit() {
    setState(() {
      _progress = 1.0;
    });

    final habitsBloc = context.read<HabitsBloc>();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      final updatedHabit = widget.habit.copyWith(
        isActive: false,
        lastCompletedTime: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      habitsBloc.add(
        UpdateHabit(
          updatedHabit.id,
          updatedHabit.title,
          updatedHabit.description ?? '',
          int.parse(updatedHabit.categoryId),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getColorFromHex(widget.category.color);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: BlocBuilder<HabitCategoryBloc, HabitCategoryState>(
                builder: (context, state) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getCategoryIcon(widget.category.id, state),
                        color: cardColor,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.category.name,
                        style: TextStyle(
                          color: cardColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.3),
                      shape: BoxShape.circle),
                  child: Text(widget.habit.icon ?? '🎯',
                      style: const TextStyle(fontSize: 48)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.habit.title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: cardColor.withValues(alpha: 0.8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.habit.description ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            color: cardColor.withValues(alpha: 0.6)),
                      ),
                      const SizedBox(height: 8),
                      LinearPercentIndicator(
                        lineHeight: 8.0,
                        percent: _progress,
                        backgroundColor: Colors.white.withValues(alpha: .5),
                        progressColor: cardColor.withValues(alpha: 0.9),
                        barRadius: const Radius.circular(4),
                        padding: EdgeInsets.zero,
                        animation: true,
                        animationDuration: 500,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: _completeHabit,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cardColor.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
