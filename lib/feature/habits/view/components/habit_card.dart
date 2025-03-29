import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

import '../../bloc/habits_bloc.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> with TickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isLoading = false;
  String? _habitStats;

  void _toggleCard() async {
    if (!_isExpanded) {
      setState(() {
        _isExpanded = true;
        _isLoading = true;
      });

      final stats = await _loadHabitStats();

      setState(() {
        _habitStats = stats;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  Future<String> _loadHabitStats() async {
    await Future.delayed(const Duration(seconds: 1)); // эмуляция задержки
    return "Статистика: 10/14 дней выполнено";
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.habit.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<HabitsBloc>().add(DeleteHabit(widget.habit.id));
      },
      child: Container(
        // duration: const Duration(milliseconds: 300),
        // curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _toggleCard,
                child: Row(
                  children: [
                    Text(widget.habit.icon ?? '', style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.habit.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (_isExpanded)
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _habitStats ?? '',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
