import 'package:go_habit/feature/habits/data/data_sources/remote/remote_habit_data_source.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

import '../../domain/repositories/habit_repository.dart';

class HabitRepositoryImplementation implements HabitRepository {
  final RemoteDataSource remoteDataSource;

  HabitRepositoryImplementation({required this.remoteDataSource});

  @override
  Future<void> addHabit(Habit habit) async {
    try {
      await remoteDataSource.addHabit(habit);
    } catch (error) {
      throw Exception('Failed to add habit: $error');
    }
  }

  @override
  Future<void> deleteHabit(String id) {
    try {
      return remoteDataSource.deleteHabit(id);
    } catch (error) {
      throw Exception('Failed to delete habit: $error');
    }
  }

  @override
  void dispose() {
    // TODO: отмена всех подписок
  }

  @override
  Future<List<Habit>> getHabits() async {
    try {
      final habits = await remoteDataSource.getHabits();
      return habits;
    } catch (error) {
      throw Exception('Failed to fetch habits: $error');
    }
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    try {
      await remoteDataSource.updateHabit(habit);
    } catch (error) {
      throw Exception('Failed to update habit: $error');
    }
  }

  @override
  Stream<List<Habit>> watchHabits() {
    return remoteDataSource.habitsStream();
  }
}
