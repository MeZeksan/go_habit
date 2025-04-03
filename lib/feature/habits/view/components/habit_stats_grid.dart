import 'package:flutter/material.dart';

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
    final grid = List<List<bool>>.generate(5, (_) => List.generate(20, (_) => false));
    for (final date in completedDates) {
      final dayDiff = today.difference(date).inDays;
      if (dayDiff >= 0 && dayDiff < 20) {
        final row = date.weekday % 5;
        final col = 19 - dayDiff;
        grid[row][col] = true;
      }
    }
    return grid;
  }
}

class HabitGridPainter extends CustomPainter {
  final int rows = 5;
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
