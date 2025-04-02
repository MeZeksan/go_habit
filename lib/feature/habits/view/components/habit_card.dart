import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final HabitCategory habitCategory;

  const HabitCard({required this.habit, required this.habitCategory, super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = hexToColor(habitCategory.color);
    return Dismissible(
      key: ValueKey(habit.id),
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
        context.read<HabitsBloc>().add(DeleteHabit(habit.id));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          // color: const Color(0xBB000000),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.black87.withValues(alpha: 0.5), shape: BoxShape.circle),
                    child: Text(habit.icon ?? '', style: const TextStyle(fontSize: 48, color: Colors.white))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        habit.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        habit.description ?? '',
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: DateTime.parse(habit.lastCompletedTime ?? '2023-03-31T00:00:00.000')
                              .difference(DateTime.now())
                              .inDays ==
                          0
                      ? null
                      : () => context.read<HabitsBloc>().add(FinishHabit(habit.id)),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: DateTime.parse(habit.lastCompletedTime ?? '2023-03-31T00:00:00.000')
                                  .difference(DateTime.now())
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
              height: 100,
              child: HabitGridPainterWidget(color: cardColor, completedDates: [
                DateTime.now(),
                DateTime.now().subtract(const Duration(days: 1)),
                DateTime.now().subtract(const Duration(days: 2))
              ]),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        getCategoryIcon(habitCategory.id),
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        habitCategory.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: habit.isActive,
                  onChanged: (value) {},
                  // onChanged: (value) => context.read<HabitsBloc>().add(ToggleHabitActivation(habit.id, value)),
                  activeColor: cardColor,
                ),
              ],
            )
          ],
        ),
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

class HabitGridPainterWidget extends StatelessWidget {
  final Color color;
  final List<DateTime> completedDates;

  const HabitGridPainterWidget({required this.color, required this.completedDates, super.key});

  @override
  Widget build(BuildContext context) {
    final data = _generateData();
    return CustomPaint(
      size: const Size(300, 50),
      painter: HabitGridPainter(color: color, data: data),
    );
  }

  List<List<bool>> _generateData() {
    final today = DateTime.now();
    final grid = List<List<bool>>.generate(7, (_) => List.generate(20, (_) => false));
    for (final date in completedDates) {
      final dayDiff = today.difference(date).inDays;
      if (dayDiff >= 0 && dayDiff < 20) {
        final row = date.weekday % 7;
        final col = 19 - dayDiff;
        grid[row][col] = true;
      }
    }
    return grid;
  }
}

class HabitGridPainter extends CustomPainter {
  final int rows = 7;
  final int cols = 20;
  final double spacing = 4;
  final double squareSize = 10;
  final Color color;
  final List<List<bool>> data;

  HabitGridPainter({required this.color, required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        paint.color = data[row][col] ? color : color.withOpacity(0.2);
        final x = col * (squareSize + spacing);
        final y = row * (squareSize + spacing);

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, squareSize, squareSize),
            Radius.circular(squareSize / 3), // Меньший радиус скругления
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(HabitGridPainter oldDelegate) => oldDelegate.data != data;
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
