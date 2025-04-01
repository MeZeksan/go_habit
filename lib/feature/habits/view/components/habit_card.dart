import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

import '../../bloc/habits_bloc.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final randomColor = getRandomColor();
    return Dismissible(
      key: ValueKey(habit.id),
      direction: DismissDirection.endToStart,
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
                Text(habit.icon ?? '', style: const TextStyle(fontSize: 24, color: Colors.white)),
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
                          : randomColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  child: HabitGridPainterWidget(color: randomColor, completedDates: [
                    DateTime.now(),
                    DateTime.now().subtract(const Duration(days: 1)),
                    DateTime.now().subtract(const Duration(days: 2))
                  ]),
                ),
                Expanded(
                  child: Switch(
                    value: habit.isActive,
                    onChanged: (value) {},
                    // onChanged: (value) => context.read<HabitsBloc>().add(ToggleHabitActivation(habit.id, value)),
                    activeColor: randomColor,
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

Color getRandomColor() {
  final Random random = Random();
  int red = random.nextInt(156) + 100; // Диапазон 100-255
  int green = random.nextInt(156) + 100; // Диапазон 100-255
  int blue = random.nextInt(156) + 100; // Диапазон 100-255

  return Color.fromARGB(255, red, green, blue);
}

class HabitGridPainterWidget extends StatelessWidget {
  final Color color;
  final List<DateTime> completedDates;

  const HabitGridPainterWidget({super.key, required this.color, required this.completedDates});

  @override
  Widget build(BuildContext context) {
    List<List<bool>> data = _generateData();
    return CustomPaint(
      size: const Size(300, 50),
      painter: HabitGridPainter(color: color, data: data),
    );
  }

  List<List<bool>> _generateData() {
    DateTime today = DateTime.now();
    List<List<bool>> grid = List.generate(7, (_) => List.generate(20, (_) => false));
    for (var date in completedDates) {
      int dayDiff = today.difference(date).inDays;
      if (dayDiff >= 0 && dayDiff < 20) {
        int row = date.weekday % 7;
        int col = 19 - dayDiff;
        grid[row][col] = true;
      }
    }
    return grid;
  }
}

class HabitGridPainter extends CustomPainter {
  final int rows = 7;
  final int cols = 20;
  final double spacing = 4.0;
  final double squareSize = 10.0;
  final Color color;
  final List<List<bool>> data;

  HabitGridPainter({required this.color, required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        paint.color = data[row][col] ? color : color.withOpacity(0.2);
        final double x = col * (squareSize + spacing);
        final double y = row * (squareSize + spacing);

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
