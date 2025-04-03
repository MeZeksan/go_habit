part of 'habit_stats_bloc.dart';

@immutable
sealed class HabitStatsEvent {}

class HabitsStatsInitialLoad extends HabitStatsEvent {}

class HabitsStatsRefresh extends HabitStatsEvent {
  final List<HabitCompletionModel> completions;

  HabitsStatsRefresh(this.completions);
}
