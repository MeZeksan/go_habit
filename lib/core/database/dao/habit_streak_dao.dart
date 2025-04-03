// habit_streak_dao.dart
import 'package:drift/drift.dart';
import 'package:go_habit/core/database/drift_database.dart';
import 'package:go_habit/core/database/tables/habit_streaks.dart';

part 'habit_streak_dao.g.dart';

@DriftAccessor(tables: [HabitStreaks])
class HabitStreakDao extends DatabaseAccessor<AppDatabase> with _$HabitStreakDaoMixin {
  final AppDatabase db;

  HabitStreakDao(this.db) : super(db);

  // Создать или обновить стрик
  Future<void> upsertStreak(
    String habitId,
    int streak,
    DateTime lastUpdate,
  ) async {
    final companion = HabitStreaksCompanion(
      habitId: Value(habitId),
      currentStreak: Value(streak),
      lastUpdate: Value(lastUpdate),
    );

    await into(habitStreaks).insertOnConflictUpdate(companion);
  }

  // Получить текущий стрик
  Future<HabitStreak?> getStreak(String habitId) async {
    final query = select(habitStreaks)..where((t) => t.habitId.equals(habitId));

    return query.getSingleOrNull();
  }

  // Увеличить стрик на 1
  // Future<void> incrementStreak(String habitId, DateTime updateDate) async {
  //   await (update(habitStreaks)..where((t) => t.habitId.equals(habitId))).write(
  //     HabitStreaksCompanion(
  //       currentStreak: const CustomExpression('current_streak + 1'),
  //       lastUpdate: Value(updateDate),
  //     ),
  //   );
  // }

  // Сбросить стрик
  Future<void> resetStreak(String habitId, DateTime updateDate) async {
    await (update(habitStreaks)..where((t) => t.habitId.equals(habitId))).write(
      HabitStreaksCompanion(
        currentStreak: const Value(0),
        lastUpdate: Value(updateDate),
      ),
    );
  }

  // Получить все стрики (для админки или аналитики)
  Future<List<HabitStreak>> getAllStreaks() async {
    return select(habitStreaks).get();
  }

  // Получить самый длинный стрик
  // Future<int> getLongestStreak(String habitId) async {
  //   final query = selectOnly(habitStreaks)
  //     ..addColumns([max(habitStreaks.currentStreak)])
  //     ..where(habitStreaks.habitId.equals(habitId));

  //   final result = await query.getSingle();
  //   return result.read(max(habitStreaks.currentStreak)) ?? 0;
  // }

  // Удалить стрик
  Future<int> deleteStreak(String habitId) async {
    return (delete(habitStreaks)..where((t) => t.habitId.equals(habitId))).go();
  }
}
