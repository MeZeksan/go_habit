import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habit_stats/bloc/habit_stats_bloc.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_completion.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:mockito/mockito.dart';

// Моки блоков
class MockHabitsBloc extends Mock implements HabitsBloc {
  @override
  Stream<HabitsState> get stream => Stream.fromIterable([]);
}

class MockHabitStatsBloc extends Mock implements HabitStatsBloc {
  final _stateController = StreamController<HabitStatsState>.broadcast();

  MockHabitStatsBloc() {
    _stateController.add(HabitStatsLoaded(const []));
  }

  @override
  HabitStatsState get state => HabitStatsLoaded(const []);

  @override
  Stream<HabitStatsState> get stream => _stateController.stream;

  @override
  Future<void> close() {
    _stateController.close();
    return Future.value();
  }
}

/// Настройка провайдеров блоков для тестов
List<BlocProvider> getMockBlocProviders() {
  final mockHabitsBloc = MockHabitsBloc();
  final mockHabitStatsBloc = MockHabitStatsBloc();

  // Настройка поведения мок-блоков
  when(mockHabitStatsBloc.state).thenReturn(HabitStatsLoaded(const []));

  return [
    BlocProvider<HabitsBloc>.value(value: mockHabitsBloc),
    BlocProvider<HabitStatsBloc>.value(value: mockHabitStatsBloc),
  ];
}

/// Виджет для оборачивания тестируемого виджета в провайдеры блоков
class MockBlocWrapper extends StatelessWidget {
  final Widget child;

  const MockBlocWrapper({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitsBloc>.value(value: MockHabitsBloc()),
        BlocProvider<HabitStatsBloc>.value(value: MockHabitStatsBloc()),
      ],
      child: child,
    );
  }
}
