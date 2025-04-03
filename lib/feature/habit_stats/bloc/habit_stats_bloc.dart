import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_completion.dart';
import 'package:go_habit/feature/habit_stats/domain/repositories/habit_stats_repository.dart';
import 'package:meta/meta.dart';

part 'habit_stats_event.dart';
part 'habit_stats_state.dart';

class HabitStatsBloc extends Bloc<HabitStatsEvent, HabitStatsState> {
  final HabitStatsRepository _repository;

  StreamSubscription<List<HabitCompletionModel>>? _subscription;

  HabitStatsBloc(this._repository) : super(HabitStatsInitial()) {
    on<HabitStatsEvent>((event, emit) async {
      switch (event) {
        case HabitsStatsInitialLoad():
          await _onInitialLoad(event, emit);
        case HabitsStatsRefresh():
          await _onRefresh(event, emit);
      }
    });

    _subscription = _repository.watchAllCompletions().listen((completions) {
      add(HabitsStatsRefresh(completions));
    });
  }

  Future<void> _onRefresh(HabitsStatsRefresh event, Emitter<HabitStatsState> emit) async {
    emit(HabitStatsLoaded(event.completions));
  }

  Future<void> _onInitialLoad(HabitStatsEvent event, Emitter<HabitStatsState> emit) async {
    try {
      emit(HabitStatsLoading());
      final habitCompletions = await _repository.getAllCompletions();

      emit(HabitStatsLoaded(habitCompletions));
    } catch (error) {
      emit(HabitStatsError());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _repository.dispose();
    return super.close();
  }
}
