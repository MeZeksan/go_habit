part of 'habit_stats_bloc.dart';

@immutable
sealed class HabitStatsState {}

final class HabitStatsInitial extends HabitStatsState {}

class HabitStatsLoading extends HabitStatsState {}

class HabitStatsLoaded extends HabitStatsState {
  final List<HabitCompletionModel> completions;

  HabitStatsLoaded(this.completions);
}

class HabitStatsError extends HabitStatsState {
  // final List<HabitCompletionModel> completions;

  // HabitStatsError(this.completions);
}
