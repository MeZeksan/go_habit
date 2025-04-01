import 'package:drift/drift.dart';

import '../../../../../core/database/dao/habits_dao.dart';
import '../../../../../core/database/drift_database.dart';
import '../../../domain/enums/sync_status.dart';
import '../../models/habit.dart' as entity;

abstract interface class LocalHabitDataSource {
  Future<List<entity.Habit>> getHabits();
  Future<entity.Habit?> getHabitById(String id);
  Future<void> saveHabit(entity.Habit habit);
  Future<void> updateHabit(entity.Habit habit);
  Future<void> deleteHabit(String id);
  Stream<List<entity.Habit>> habitsStream();
  Future<void> saveAllHabits(List<entity.Habit> habits);
  Future<void> markHabitAsSynced(String habitId);
  Future<void> markHabitAsPendingSync(String habitId, SyncStatus syncStatus);
  Future<List<entity.Habit>> getPendingSyncHabits();
}

class DriftHabitDataSource implements LocalHabitDataSource {
  final HabitsDao _habitsDao;

  DriftHabitDataSource(this._habitsDao);

  @override
  Future<void> saveHabit(entity.Habit habit) async {
    await _habitsDao.addHabit(HabitsCompanion(
        id: Value(habit.id),
        title: Value(habit.title),
        description: Value(habit.description),
        categoryId: Value(habit.categoryId),
        isActive: Value(habit.isActive),
        icon: Value(habit.icon ?? '🎯')));
  }

  @override
  Future<void> deleteHabit(String id) async {
    await _habitsDao.deleteHabit(id);
  }

  @override
  Future<entity.Habit?> getHabitById(String id) async {
    final habit = await _habitsDao.getHabitById(id);
    if (habit == null) return null;
    return entity.Habit.fromDriftModel(habit);
  }

  @override
  Future<List<entity.Habit>> getHabits() async {
    final result = await _habitsDao.getAllHabits();
    return result.map((e) {
      return entity.Habit.fromDriftModel(e);
    }).toList();
  }

  @override
  Future<void> updateHabit(entity.Habit habit) async {
    await _habitsDao.updateHabit(habit.id,
        title: habit.title,
        description: habit.description,
        categoryId: habit.categoryId,
        steps: habit.steps,
        isActive: habit.isActive,
        lastTimeCompleted: DateTime.tryParse(habit.lastCompletedTime ?? ''),
        isPendingSync: true,
        syncStatus: 'update');
  }

  @override
  Stream<List<entity.Habit>> habitsStream() =>
      _habitsDao.watchHabits().map((event) => event.map((e) => entity.Habit.fromDriftModel(e)).toList());

  @override
  Future<void> saveAllHabits(List<entity.Habit> habits) async {
    await _habitsDao.batch((batch) {
      batch.insertAll(
        _habitsDao.habits,
        habits.map(_toCompanion),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<List<entity.Habit>> getPendingSyncHabits() async {
    final pendingForAdd = await _habitsDao.getHabitsBySyncStatus(
      syncStatus: 'add',
      isPending: true,
    );
    final pendingForUpdate = await _habitsDao.getHabitsBySyncStatus(
      syncStatus: 'update',
      isPending: true,
    );
    final pendingForDelete = await _habitsDao.getHabitsBySyncStatus(
      syncStatus: 'delete',
      isPending: true,
    );
    final result = [...pendingForAdd, ...pendingForUpdate, ...pendingForDelete];

    return result.map((e) => entity.Habit.fromDriftModel(e)).toList();
  }

  @override
  Future<void> markHabitAsPendingSync(String habitId, SyncStatus syncStatus) async {
    await _habitsDao.updateHabit(
      habitId,
      isPendingSync: true,
      syncStatus: switch (syncStatus) {
        SyncStatus.add => 'add',
        SyncStatus.update => 'update',
        SyncStatus.delete => 'delete',
        SyncStatus.synced => 'synced',
      },
    );
  }

  @override
  Future<void> markHabitAsSynced(String habitId) async {
    await _habitsDao.updateHabit(
      habitId,
      isPendingSync: false,
      syncStatus: 'synced',
    );
  }

  HabitsCompanion _toCompanion(entity.Habit habit) {
    return HabitsCompanion.insert(
      id: habit.id,
      title: habit.title,
      description: Value(habit.description),
      categoryId: habit.categoryId,
      lastTimeCompleted: Value(habit.lastCompletedTime == null ? null : DateTime.parse(habit.lastCompletedTime!)),
      createdAt: Value(DateTime.tryParse(habit.createdAt ?? '') ?? DateTime.now()),
      updatedAt: Value(DateTime.tryParse(habit.updatedAt ?? '') ?? DateTime.now()),
      isActive: Value(habit.isActive),
      isPendingSync: const Value(false),
    );
  }
}
