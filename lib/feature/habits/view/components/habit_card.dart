import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:go_habit/feature/habit_stats/bloc/habit_stats_bloc.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:go_habit/feature/habits/view/components/habit_stats_grid.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final HabitCategory habitCategory;

  const HabitCard({required this.habit, required this.habitCategory, super.key});

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: widget.habit.isActive ? 1.0 : 0.5,
      end: widget.habit.isActive ? 1.0 : 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: widget.habit.isActive ? Colors.white : Colors.grey,
      end: widget.habit.isActive ? Colors.white : Colors.grey,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant HabitCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.habit.isActive != widget.habit.isActive) {
      _opacityAnimation = Tween<double>(
        begin: oldWidget.habit.isActive ? 1.0 : 0.5,
        end: widget.habit.isActive ? 1.0 : 0.5,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _colorAnimation = ColorTween(
        begin: oldWidget.habit.isActive ? Colors.white : Colors.grey,
        end: widget.habit.isActive ? Colors.white : Colors.grey,
      ).animate(_animationController);

      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = hexToColor(widget.habitCategory.color);
    final isActive = widget.habit.isActive;

    return Dismissible(
      key: ValueKey(widget.habit.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return _showConfirmDialog(context);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        context.read<HabitsBloc>().add(DeleteHabit(widget.habit.id));
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isActive ? Colors.transparent : Colors.grey.withOpacity(0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black87.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          widget.habit.icon ?? '',
                          style: TextStyle(
                            fontSize: 48,
                            color: _colorAnimation.value,
                          ),
                        ),
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
                                color: _colorAnimation.value,
                                decoration: isActive ? null : TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.habit.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: _colorAnimation.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isActive)
                        InkWell(
                          onTap: DateTime.parse(widget.habit.lastCompletedTime ?? '2023-03-31T00:00:00.000')
                                      .difference(DateTime.now())
                                      .inDays ==
                                  0
                              ? () {
                                  context.read<HabitsBloc>().add(UnFinishHabit(widget.habit.id));
                                }
                              : () {
                                  context.read<HabitsBloc>().add(FinishHabit(widget.habit.id));
                                },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: DateTime.now()
                                          .difference(DateTime.parse(
                                              widget.habit.lastCompletedTime ?? '2023-03-31T00:00:00.000'))
                                          .inDays ==
                                      0
                                  ? Colors.grey
                                  : cardColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.check, color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 70,
                    child: isActive
                        ? BlocBuilder<HabitStatsBloc, HabitStatsState>(
                            builder: (context, state) {
                              switch (state) {
                                case HabitStatsLoaded(:final completions):
                                  return HabitGridPainterWidget(
                                    color: cardColor,
                                    completedDates: completions
                                        .where((c) => c.habitId == widget.habit.id)
                                        .map((c) => c.dateComplete)
                                        .toList(),
                                  );
                                case _:
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.white,
                                    ),
                                  );
                              }
                            },
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Привычка неактивна',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: cardColor.withOpacity(isActive ? 1.0 : 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              getCategoryIcon(widget.habitCategory.id),
                              color: _colorAnimation.value,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.habitCategory.name,
                              style: TextStyle(
                                color: _colorAnimation.value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: widget.habit.isActive,
                        onChanged: (value) {
                          context.read<HabitsBloc>().add(ToggleActiveHabit(widget.habit.id));
                        },
                        activeColor: cardColor,
                        inactiveThumbColor: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Color getRandomColor() {
  final random = Random();
  final red = random.nextInt(156) + 100; // Диапазон 100-255
  final green = random.nextInt(156) + 100; // Диапазон 100-255
  final blue = random.nextInt(156) + 100; // Диапазон 100-255

  return Color.fromARGB(255, red, green, blue);
}

Color hexToColor(String hexString) {
  // Удаляем возможный префикс '#'
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) {
    buffer.write('ff'); // Добавляем непрозрачность (alpha) по умолчанию
  }
  buffer.write(hexString.replaceFirst('#', ''));

  // Преобразуем в целое число и создаем Color
  return Color(int.parse(buffer.toString(), radix: 16));
}

Future<bool> _showConfirmDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Удалить привычку?'),
          content: const Text('Вы уверены, что хотите удалить эту привычку?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Удалить', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ) ??
      false;
}

IconData getCategoryIcon(String categoryId) {
  switch (categoryId) {
    case 'art':
      return Icons.brush; // Иконка творчества
    case 'education':
      return Icons.school; // Иконка обучения
    case 'health':
      return Icons.fitness_center; // Иконка здоровья
    case 'money':
      return Icons.attach_money; // Иконка финансов
    case 'selv-development':
      return Icons.self_improvement; // Саморазвитие
    case 'sport':
      return Icons.sports_soccer; // Иконка спорта
    case 'work':
      return Icons.work; // Иконка работы
    default:
      return Icons.category; // Иконка по умолчанию
  }
}
