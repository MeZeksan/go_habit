import 'package:go_habit/core/app_connect/src/app_connect.dart';
import 'package:go_habit/feature/habit_stats/data/data_sources/local/local_habit_stats_datasource.dart';
import 'package:go_habit/feature/habit_stats/data/data_sources/remote/remote_habit_stats_datasource.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_completion.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_streak.dart';
import 'package:go_habit/feature/habit_stats/domain/repositories/habit_stats_repository.dart';

class HabitStatsRepositoryImplementation implements HabitStatsRepository {
  final LocalHabitStatsDataSource _localDataSource;
  final RemoteHabitStatsDataSource _remoteDataSource;
  final IAppConnect _appConnect;

  HabitStatsRepositoryImplementation(this._localDataSource, this._remoteDataSource, this._appConnect);

  @override
  Future<List<HabitCompletionModel>> getAllCompletions() async {
    try {
      if (await _appConnect.hasConnect()) {
        final completions = await _remoteDataSource.fetchAllCompletions();
        await _localDataSource.saveCompletions(completions);
        return completions;
      }

      return await _localDataSource.getAllCompletions();
    } catch (e) {
      throw Exception('Failed to get completions: $e');
    }
  }

  @override
  Future<HabitStreakModel?> getStreak(String habitId) async {
    try {
      if (await _appConnect.hasConnect()) {
        final streak = _remoteDataSource.fetchStreak(habitId);
        return streak;
      }

      return _localDataSource.getStreak(habitId);
    } catch (error) {
      throw Exception('Failed to get streak: $error');
    }
  }

  @override
  Future<void> saveCompletions(List<HabitCompletionModel> completions) {
    // TODO: implement saveCompletions
    throw UnimplementedError();
  }

  @override
  Future<void> saveStreak(HabitStreakModel streak) {
    // TODO: implement saveStreak
    throw UnimplementedError();
  }

  @override
  Stream<List<HabitCompletionModel>> watchAllCompletions() {
    return _localDataSource.watchAllCompletions();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
