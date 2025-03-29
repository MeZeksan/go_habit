import 'package:drift/drift.dart';

import '../drift_database.dart';
import '../tables/habits.dart';

part 'habits_dao.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [Habits])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  HabitsDao(super.db);

  Future<List<Habit>> getAllHabits() => select(habits).get();

  Future<Habit?> getHabitById(String id) => (select(habits)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<int> addHabit(HabitsCompanion entry) async {
    return await habits.insert().insert(entry);
  }

  Future<int> updateHabit(String habitId,
      {String? title,
      String? description,
      String? categoryId,
      int? steps,
      bool? isActive,
      DateTime? lastTimeCompleted,
      String? syncStatus,
      bool? isPendingSync}) {
    final companion = HabitsCompanion(
      title: title == null ? const Value.absent() : Value(title),
      description: description == null ? const Value.absent() : Value(description),
      categoryId: categoryId == null ? const Value.absent() : Value(categoryId),
      isActive: isActive == null ? const Value.absent() : Value(isActive),
      steps: steps == null ? const Value.absent() : Value(steps),
      lastTimeCompleted: lastTimeCompleted == null ? const Value.absent() : Value(lastTimeCompleted),
      updatedAt: Value(DateTime.now()),
      isPendingSync: isPendingSync == null ? const Value.absent() : Value(isPendingSync),
      syncStatus: syncStatus == null ? const Value.absent() : Value(syncStatus),
    );

    return (update(habits)..where((tbl) => tbl.id.equals(habitId))).write(companion);
  }

  Stream<List<Habit>> watchHabits() => select(habits).watch();

  Future<int> deleteHabit(String id) => (delete(habits)..where((tbl) => tbl.id.equals(id))).go();

  Future<List<Habit>> getHabitsBySyncStatus({required String syncStatus, required bool isPending}) =>
      (select(habits)..where((tbl) => tbl.syncStatus.equals(syncStatus) & tbl.isPendingSync.equals(isPending))).get();

  Future<void> deleteAllHabits() async {
    await (delete(habits)).go();
  }
}
