import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_habit/core/app_connect/src/app_connect.dart';
import 'package:go_habit/feature/habits/data/data_sources/local/local_habit_data_source.dart';
import 'package:go_habit/feature/habits/data/data_sources/remote/remote_habit_data_source.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:go_habit/feature/habits/domain/enums/sync_status.dart';
import 'package:go_habit/feature/habits/domain/repositories/habit_repository.dart';

class HabitsRepositoryImplementation implements HabitRepository {
  final LocalHabitDataSource _localDataSource;
  final RemoteHabitDataSource _remoteDataSource;
  final IAppConnect _appConnect;

  late final StreamSubscription<bool>? _subscription;

  HabitsRepositoryImplementation(
    this._localDataSource,
    this._remoteDataSource,
    this._appConnect,
  ) {
    // При изменении статуса подключения запускаем синхронизацию
    _subscription = _appConnect.onConnectChanged.listen((isConnected) {
      if (isConnected) {
        // Затем выполняем полное слияние данных
        _fullSync();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }

  @override
  Future<List<Habit>> getHabits() async {
    try {
      if (await _appConnect.hasConnect()) {
        await _fullSync();
      }
      return await _localDataSource.getHabits();
    } catch (e) {
      throw Exception('Failed to get habits: $e');
    }
  }

  @override
  Future<void> addHabit(Habit habit) async {
    try {
      // Сохраняем локально сразу
      await _localDataSource.saveHabit(habit);

      if (await _appConnect.hasConnect()) {
        try {
          // Пытаемся отправить на сервер
          await _remoteDataSource.addHabit(habit);
          await _localDataSource.markHabitAsSynced(habit.id);
        } catch (e) {
          // Если не удалось, помечаем для последующей синхронизации
          await _localDataSource.markHabitAsPendingSync(habit.id, SyncStatus.add);
        }
      } else {
        // Если нет подключения, сохраняем статус pending
        await _localDataSource.markHabitAsPendingSync(habit.id, SyncStatus.add);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    try {
      await _localDataSource.updateHabit(habit);

      if (await _appConnect.hasConnect()) {
        try {
          await _remoteDataSource.updateHabit(habit);
          await _localDataSource.markHabitAsSynced(habit.id);
        } catch (e) {
          await _localDataSource.markHabitAsPendingSync(habit.id, SyncStatus.update);
        }
      } else {
        await _localDataSource.markHabitAsPendingSync(habit.id, SyncStatus.update);
      }
    } catch (e) {
      throw Exception('Failed to update habit: $e');
    }
  }

  @override
  Future<void> deleteHabit(String id) async {
    try {
      if (await _appConnect.hasConnect()) {
        await _remoteDataSource.deleteHabit(id);
        await _localDataSource.deleteHabit(id);
      } else {
        await _localDataSource.markHabitAsPendingSync(id, SyncStatus.delete);
      }
    } catch (e) {
      throw Exception('Failed to delete habit: $e');
    }
  }

  /// Сначала обрабатываем ожидающие операции (pending), чтобы сервер был актуальным,
  /// а затем выполняем полное слияние локальных и серверных данных.
  Future<void> syncPendingOperations() async {
    if (!await _appConnect.hasConnect()) return;

    try {
      final pendingHabits = await _localDataSource.getPendingSyncHabits();

      for (final habit in pendingHabits) {
        try {
          switch (habit.syncStatus) {
            case SyncStatus.add:
              await _remoteDataSource.addHabit(habit);
              await _localDataSource.markHabitAsSynced(habit.id);
            case SyncStatus.update:
              await _remoteDataSource.updateHabit(habit);
              await _localDataSource.markHabitAsSynced(habit.id);
            case SyncStatus.delete:
              await _remoteDataSource.deleteHabit(habit.id);
              await _localDataSource.deleteHabit(habit.id);
            default:
              continue;
          }
        } catch (e) {
          debugPrint('Failed to sync habit ${habit.id} with status ${habit.syncStatus}: $e');
        }
      }
    } catch (e) {
      throw Exception('Sync failed: $e');
    }
  }

  /// Полная синхронизация данных: слияние серверных и локальных записей.
  /// Особое внимание уделено тому, чтобы не удалить локально записи,
  /// добавленные оффлайн и ожидающие синхронизации (SyncStatus.add).
  Future<void> _fullSync() async {
    if (!await _appConnect.hasConnect()) return;

    try {
      // Обновляем сервер данными из ожидающих операций
      await syncPendingOperations();

      // 1. Получаем привычки с сервера и из локальной базы
      final remoteHabits = await _remoteDataSource.getHabits();
      final localHabits = await _localDataSource.getHabits();

      // 2. Формируем словари для быстрого доступа по id
      final remoteMap = {for (final habit in remoteHabits) habit.id: habit};
      final localMap = {for (final habit in localHabits) habit.id: habit};

      // 3. Обработка привычек, присутствующих на сервере
      for (final remoteHabit in remoteHabits) {
        if (localMap.containsKey(remoteHabit.id)) {
          final localHabit = localMap[remoteHabit.id]!;

          // Если время обновления определено, сравниваем версии
          if (remoteHabit.updatedAt != null &&
              localHabit.updatedAt != null &&
              DateTime.tryParse(remoteHabit.updatedAt!)!.isAfter(DateTime.tryParse(localHabit.updatedAt!)!)) {
            // Серверная версия новее — обновляем локальную запись
            await _localDataSource.updateHabit(remoteHabit);
            await _localDataSource.markHabitAsSynced(remoteHabit.id);
          } else if (remoteHabit.updatedAt != null &&
              localHabit.updatedAt != null &&
              DateTime.tryParse(localHabit.updatedAt!)!.isAfter(DateTime.tryParse(remoteHabit.updatedAt!)!)) {
            // Локальная версия новее — отправляем обновление на сервер
            await _remoteDataSource.updateHabit(localHabit);
            await _localDataSource.markHabitAsSynced(localHabit.id);
          }
          // Если времена обновления равны, оставляем запись без изменений
        } else {
          // Привычка присутствует на сервере, но отсутствует локально — добавляем её
          await _localDataSource.saveHabit(remoteHabit);
        }
      }

      // 4. Обработка привычек, которые существуют только локально
      for (final localHabit in localHabits) {
        if (!remoteMap.containsKey(localHabit.id)) {
          // Если привычка помечена на удаление, удаляем её локально
          if (localHabit.syncStatus == SyncStatus.delete) {
            await _localDataSource.deleteHabit(localHabit.id);
          }
          // Если привычка добавлена или обновлена оффлайн (pending), пытаемся отправить её на сервер
          else if (localHabit.syncStatus == SyncStatus.add || localHabit.syncStatus == SyncStatus.update) {
            await _remoteDataSource.addHabit(localHabit);
            await _localDataSource.markHabitAsSynced(localHabit.id);
          }
          // Если запись не имеет флага синхронизации, вероятно, её удалили на сервере — удаляем локально
          else {
            await _localDataSource.deleteHabit(localHabit.id);
          }
        }
      }

      // 5. Финальная обработка ожидающих операций,
      // чтобы учесть возможные изменения, возникшие в процессе слияния.
      await syncPendingOperations();
    } catch (e) {
      debugPrint('Full sync failed: $e');
      throw Exception('Full sync failed: $e');
    }
  }

  @override
  Stream<List<Habit>> watchHabits() {
    return _localDataSource.habitsStream();
  }
}
