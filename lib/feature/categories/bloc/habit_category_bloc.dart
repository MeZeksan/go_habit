import 'package:bloc/bloc.dart';
import 'package:go_habit/feature/categories/domain/repositories/habit_category_repository.dart';
import 'package:meta/meta.dart';

import '../domain/models/habit_category.dart';

part 'habit_category_event.dart';
part 'habit_category_state.dart';

class HabitCategoryBloc extends Bloc<HabitCategoryEvent, HabitCategoryState> {
  final HabitCategoryRepository _habitCategoryRepository;

  HabitCategoryBloc(this._habitCategoryRepository) : super(HabitCategoryInitial()) {
    on<HabitCategoryEvent>((event, emit) async {
      switch (event) {
        case HabitInitialLoad():
          await _onInitializeHabitsCategories(event, emit);
      }
    });
  }

  Future<void> _onInitializeHabitsCategories(HabitInitialLoad event, Emitter<HabitCategoryState> emit) async {
    emit(HabitCategoryLoading());
    try {
      final habits = await _habitCategoryRepository.getHabitCategories();
      emit(HabitCategoryLoaded(habits));
    } catch (error) {
      emit(HabitCategoryError());
    }
  }
}
