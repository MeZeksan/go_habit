import 'package:drift/drift.dart';
import 'package:go_habit/core/database/dao/habit_completion_dao.dart';
import 'package:go_habit/core/database/dao/habit_streak_dao.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_completion.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_streak.dart';

abstract interface class LocalHabitStatsDataSource {
  Future<List<HabitCompletionModel>> getAllCompletions();
  Future<HabitStreakModel?> getStreak(String habitId);
  Future<void> saveCompletions(List<HabitCompletionModel> completions);
  Future<void> saveStreak(HabitStreakModel streak);
}

class LocalStatsDataSourceImpl implements LocalHabitStatsDataSource {
  final HabitCompletionDao _completionDao;
  final HabitStreakDao _streakDao;

  LocalStatsDataSourceImpl(this._completionDao, this._streakDao);

  @override
  Future<List<HabitCompletionModel>> getAllCompletions() async {
    final completions = await _completionDao.getAllCompletions();

    return completions.map(HabitCompletionModel.fromDriftModel).toList();
  }

  @override
  Future<HabitStreakModel?> getStreak(String habitId) async {
    final streak = await _streakDao.getStreak(habitId);
    return streak != null ? HabitStreakModel.fromDriftModel(streak) : null;
  }

  @override
  Future<void> saveCompletions(List<HabitCompletionModel> completions) async {
    await _completionDao.db.batch((batch) {
      batch.insertAll(
        _completionDao.habitCompletions,
        completions.map((e) => e.toDriftModel()).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> saveStreak(HabitStreakModel streak) async {
    await _streakDao.upsertStreak(
      streak.habitId,
      streak.currentStreak,
      streak.lastUpdate,
    );
  }
}
