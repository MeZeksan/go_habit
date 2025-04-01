part of 'habit_category_bloc.dart';

@immutable
sealed class HabitCategoryEvent {}

final class HabitInitialLoad extends HabitCategoryEvent {}
