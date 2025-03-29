import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:go_habit/feature/habits/domain/repositories/habit_repository.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final HabitRepository _habitRepository;
  StreamSubscription<List<Habit>>? _subscription;

  HabitsBloc(this._habitRepository) : super(HabitsInitial()) {
    on<HabitsEvent>((event, emit) async {
      switch (event) {
        case InitializeHabits():
          await _onInitializeHabits(event, emit);
        case LoadHabits():
          await _onLoadHabits(event, emit);
        case AddHabit():
          await _onAddHabit(event, emit);
        case UpdateHabit():
          await _onUpdateHabit(event, emit);
        case DeleteHabit():
          await _onDeleteHabit(event, emit);
        case FinishHabit():
          await _onFinishHabit(event, emit);
      }
    });

    _subscription = _habitRepository.watchHabits().listen((habits) {
      add(LoadHabits(habits));
    });

    add(InitializeHabits());
  }

  Future<void> _onInitializeHabits(InitializeHabits event, Emitter<HabitsState> emit) async {
    try {
      final habits = await _habitRepository.getHabits();
      for (var element in habits) {
        debugPrint(element.toString());
      }
      emit(HabitsLoadSuccess(habits));
    } catch (error) {
      emit(HabitsOperationFailure(error: error.toString(), habits: state.habits));
    }
  }

  Future<void> _onLoadHabits(LoadHabits event, Emitter<HabitsState> emit) async {
    emit(HabitsLoadSuccess(event.habits));
  }

  Future<void> _onAddHabit(AddHabit event, Emitter<HabitsState> emit) async {
    if (event.title.isEmpty || event.description.isEmpty) {
      emit(HabitsOperationFailure(error: 'Please enter title and description', habits: state.habits));
      return;
    }

    try {
      final habit = Habit(title: event.title, description: event.description, categoryId: event.categoryKey);
      await _habitRepository.addHabit(habit);
      emit(HabitsOperationSuccess(message: 'Habit is added', habits: state.habits));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(HabitsOperationFailure(error: error.toString(), habits: state.habits));
    }
  }

  Future<void> _onUpdateHabit(UpdateHabit event, Emitter<HabitsState> emit) async {
    try {
      final editedHabit = state.habits.firstWhere((element) => element.id == event.id).copyWith(
            title: event.title,
            description: event.description,
          );
      await _habitRepository.updateHabit(editedHabit);
      emit(HabitsOperationSuccess(message: 'Habit is updated', habits: state.habits));
    } catch (error) {
      emit(HabitsOperationFailure(error: error.toString(), habits: state.habits));
    }
  }

  Future<void> _onDeleteHabit(DeleteHabit event, Emitter<HabitsState> emit) async {
    try {
      await _habitRepository.deleteHabit(event.id);
      emit(HabitsOperationSuccess(message: 'Habit is deleted', habits: state.habits));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(HabitsOperationFailure(error: error.toString(), habits: state.habits));
    }
  }

  Future<void> _onFinishHabit(FinishHabit event, Emitter<HabitsState> emit) async {
    try {
      final finishedHabit = state.habits.firstWhere((element) => element.id == event.id).copyWith(
            lastCompletedTime: DateTime.now().toIso8601String(),
          );
      await _habitRepository.updateHabit(finishedHabit);
      emit(HabitsOperationSuccess(message: 'Habit is finished', habits: state.habits));
    } catch (error) {
      emit(HabitsOperationFailure(error: error.toString(), habits: state.habits));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _habitRepository.dispose();
    return super.close();
  }
}
