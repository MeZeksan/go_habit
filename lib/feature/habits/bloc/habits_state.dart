part of 'habits_bloc.dart';

sealed class HabitsState {
  final List<Habit> habits;

  const HabitsState({this.habits = const []});
}

final class HabitsInitial extends HabitsState {}

final class HabitsLoading extends HabitsState {
  @override
  final List<Habit> habits;

  HabitsLoading(this.habits);
}

class HabitsLoadSuccess extends HabitsState {
  @override
  final List<Habit> habits;

  HabitsLoadSuccess(this.habits);
}

class HabitsOperationSuccess extends HabitsState {
  @override
  final List<Habit> habits;
  final String message;

  HabitsOperationSuccess({required this.habits, required this.message});
}

class HabitsOperationFailure extends HabitsState {
  @override
  final List<Habit> habits;
  final String error;

  HabitsOperationFailure({required this.habits, required this.error});
}
