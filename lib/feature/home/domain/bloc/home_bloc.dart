/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HabitsBloc _habitsBloc;

  HomeBloc(this._habitsBloc) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      switch (event) {
        case InitializeHome():
          await _onInitializeHome(event, emit);
        case RefreshHabits():
          await _onRefreshHabits(event, emit);
      }
    });

    _habitsBloc.stream.listen((state) {
      if (state is HabitsLoadSuccess) {
        add(RefreshHabits(state.habits));
      }
    });
  }

  Future<void> _onInitializeHome(
      InitializeHome event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      _habitsBloc.add(InitializeHabits());
      emit(HomeLoadSuccess());
    } catch (error) {
      emit(HomeOperationFailure(error: error.toString()));
    }
  }

  Future<void> _onRefreshHabits(
      RefreshHabits event, Emitter<HomeState> emit) async {
    emit(HomeLoadSuccess());
  }
}
*/
