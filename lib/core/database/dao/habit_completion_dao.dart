// habit_completion_dao.dart
import 'package:drift/drift.dart';
import 'package:go_habit/core/database/drift_database.dart';
import 'package:go_habit/core/database/tables/habit_completions.dart';

part 'habit_completion_dao.g.dart';

@DriftAccessor(tables: [HabitCompletions])
class HabitCompletionDao extends DatabaseAccessor<AppDatabase> with _$HabitCompletionDaoMixin {
  final AppDatabase db;

  HabitCompletionDao(this.db) : super(db);

  // Создать новое выполнение
  Future<int> createCompletion(
    String habitId,
    String userId,
    DateTime date,
  ) async {
    final completion = HabitCompletionsCompanion(
      habitId: Value(habitId),
      dateComplete: Value(date),
    );

    return into(habitCompletions).insert(completion);
  }

  Stream<List<HabitCompletion>> watchHabitCompletions() => select(habitCompletions).watch();

  // Получить все выполнения для привычки
  Future<List<HabitCompletion>> getAllCompletions() async {
    final query = select(habitCompletions);
    // ..where((t) => t.habitId.equals(habitId))
    // ..orderBy([(t) => OrderingTerm(expression: t.dateComplete)]);

    return query.get();
  }

  // Удалить выполнение
  Future<int> deleteCompletion(int id) async {
    return (delete(habitCompletions)..where((t) => t.id.equals(id))).go();
  }

  // Проверить, выполнена ли привычка в указанную дату
  Future<bool> isHabitCompletedOnDate(
    String habitId,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = select(habitCompletions)
      ..where((t) => t.habitId.equals(habitId) & t.dateComplete.isBetweenValues(startOfDay, endOfDay))
      ..limit(1);

    return query.getSingleOrNull() != null;
  }

  // Получить количество выполнениий за период
  // Future<int> getCompletionCount(
  //   String habitId,
  //   DateTime startDate,
  //   DateTime endDate,
  // ) async {
  //   final query = selectOnly(habitCompletions)
  //     ..addColumns([count()])
  //     ..where(habitCompletions.habitId.equals(habitId))
  //     ..where(habitCompletions.dateComplete.isBetweenValues(startDate, endDate));

  //   final result = await query.getSingle();
  //   return result.read(count()) ?? 0;
  // }
}
