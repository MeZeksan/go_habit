part of 'habit_category_bloc.dart';

@immutable
sealed class HabitCategoryState {}

final class HabitCategoryInitial extends HabitCategoryState {}

final class HabitCategoryLoading extends HabitCategoryState {}

final class HabitCategoryLoaded extends HabitCategoryState {
  final List<HabitCategory> categories;

  HabitCategoryLoaded(this.categories);
}

final class HabitCategoryError extends HabitCategoryState {
  final List<HabitCategory> categories;

  HabitCategoryError()
      : categories = [
          HabitCategory(id: 'art', name: 'Творчество', color: '#8E24AA'),
          HabitCategory(id: 'education', name: 'Обучение', color: '#FB8C00'),
          HabitCategory(id: 'health', name: 'Здоровье', color: '#FF6B6B'),
          HabitCategory(id: 'money', name: 'Финансы', color: '#00ACC1'),
          HabitCategory(id: 'selv-development', name: 'Саморазвитие', color: '#FDD835'),
          HabitCategory(id: 'sport', name: 'Спорт', color: '#4ECDC4'),
          HabitCategory(id: 'work', name: 'Работа', color: '#556270'),
        ];
}
