import 'package:go_habit/feature/habit_stats/domain/models/habit_completion.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_streak.dart';

abstract interface class HabitStatsRepository {
  Future<List<HabitCompletionModel>> getAllCompletions();
  Future<HabitStreakModel?> getStreak(String habitId);
  Future<void> saveCompletions(List<HabitCompletionModel> completions);
  Future<void> saveStreak(HabitStreakModel streak);
}
