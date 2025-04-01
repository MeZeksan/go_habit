part of 'habits_bloc.dart';

sealed class HabitsEvent {}

final class LoadHabits extends HabitsEvent {
  final List<Habit> habits;

  LoadHabits(this.habits);
}

final class AddHabit extends HabitsEvent {
  final String title;
  final String description;
  final String categoryKey;
  final String emojiIcon;
  AddHabit({required this.title, required this.description, required this.categoryKey, required this.emojiIcon});
}

final class UpdateHabit extends HabitsEvent {
  final String id;
  final String title;
  final String description;
  final int categoryId;
  UpdateHabit(this.id, this.title, this.description, this.categoryId);
}

final class DeleteHabit extends HabitsEvent {
  final String id;
  DeleteHabit(this.id);
}

final class FinishHabit extends HabitsEvent {
  final String id;
  FinishHabit(this.id);
}

final class InitializeHabits extends HabitsEvent {}
