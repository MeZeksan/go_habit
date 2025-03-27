// import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_habit/core/app_connect/src/app_connect.dart';
import 'package:go_habit/core/database/dao/habits_dao.dart';
import 'package:go_habit/core/database/drift_database.dart' as drift;
import 'package:go_habit/feature/habits/data/data_sources/local/local_habit_data_source.dart';
import 'package:go_habit/feature/habits/data/data_sources/remote/remote_habit_data_source.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:go_habit/feature/habits/data/repositories/habit_repository_implementation.dart';
import 'package:go_habit/feature/habits/domain/enums/sync_status.dart';
import 'package:go_habit/feature/habits/domain/repositories/habit_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<HabitsDao>(),
  MockSpec<RemoteHabitDataSource>(),
  MockSpec<LocalHabitDataSource>(),
  MockSpec<IAppConnect>(),
  MockSpec<HabitRepository>()
])
import 'habits_test.mocks.dart';

void main() {
  late MockHabitsDao habitsDao;
  late DriftHabitDataSource localDatasource;
  late Habit testHabit;

  late MockLocalHabitDataSource localDataSource;
  late MockRemoteHabitDataSource remoteDataSource;
  late MockIAppConnect appConnect;
  late HabitsRepositoryImplementation habitsRepository;

  setUp(() {
    habitsDao = MockHabitsDao();
    localDatasource = DriftHabitDataSource(habitsDao);
    localDataSource = MockLocalHabitDataSource();
    remoteDataSource = MockRemoteHabitDataSource();
    appConnect = MockIAppConnect();
    habitsRepository = HabitsRepositoryImplementation(localDataSource, remoteDataSource, appConnect);
    testHabit = Habit(
        id: '1',
        title: 'title',
        description: 'description',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        isActive: true,
        lastCompletedDate: DateTime.now().toIso8601String(),
        categoryId: 1,
        steps: 0);
  });

  //Group for Local Datasource
  group('Habits Local DataSource', () {
    test('Get habits from local datasource', () async {
      when(habitsDao.getAllHabits()).thenAnswer(
        (_) async => Future.value(
          [
            drift.Habit(
                id: '1',
                title: 'title',
                description: 'description',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                isPendingSync: false,
                isActive: true,
                syncStatus: 'synced',
                categoryId: 1,
                steps: 0,
                icon: '%'),
            drift.Habit(
                id: '2',
                title: 'title',
                description: 'description',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                isPendingSync: false,
                isActive: true,
                syncStatus: 'synced',
                categoryId: 2,
                steps: 4,
                icon: '*')
          ],
        ),
      );
      final result = await localDatasource.getHabits();

      expect(result.length, 2);
      verify(habitsDao.getAllHabits()).called(1);
    });

    test('Get habits from local datasource with Error', () async {
      when(habitsDao.getAllHabits()).thenThrow(
        Exception('Ошибка получения привычек'),
      );

      try {
        await localDatasource.getHabits();
        fail('Ожидалось исключение, но оно не было выброшено');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), contains('Ошибка получения привычек'));
      }

      verify(habitsDao.getAllHabits()).called(1);
    });

    test('Save habit to local datasource', () async {
      when(habitsDao.addHabit(any)).thenAnswer((_) async => Future.value(1));

      await localDatasource.saveHabit(testHabit);

      var captured = verify(habitsDao.addHabit(captureAny)).captured;

      expect(captured.length, 1);

      drift.HabitsCompanion capturedHabit = captured.first;
      expect(capturedHabit.id.value, '1');
      expect(capturedHabit.title.value, 'title');
      expect(capturedHabit.description.value, 'description');
    });

    test(
      'Save habit to local datasource with Error',
      () async {
        when(habitsDao.addHabit(any)).thenThrow(
          Exception('Ошибка сохранения привычки'),
        );

        try {
          await localDatasource.saveHabit(testHabit);

          var captured = verify(habitsDao.addHabit(captureAny)).captured;

          expect(captured.length, 1);

          drift.HabitsCompanion capturedHabit = captured.first;
          expect(capturedHabit.id.value, '1');
          expect(capturedHabit.title.value, 'title');
          expect(capturedHabit.description.value, 'description');

          fail('Ожидалось исключение, но оно не было выброшено');
        } catch (e) {
          expect(e, isA<Exception>());
          expect(e.toString(), contains('Ошибка сохранения привычки'));
        }
      },
    );

    test('Delete habit from local datasource', () async {
      when(habitsDao.deleteHabit(any)).thenAnswer((_) async => Future.value(1));

      await localDatasource.deleteHabit('1');

      String captured = verify(habitsDao.deleteHabit(captureAny)).captured.first;
      expect(captured, '1');
    });

    test('Delete habit from local datasource with Error', () async {
      when(habitsDao.deleteHabit(any)).thenThrow(
        Exception('Ошибка удаления привычки'),
      );

      try {
        await localDatasource.deleteHabit('1');
        String captured = verify(habitsDao.deleteHabit(captureAny)).captured.first;
        expect(captured, '1');
        fail('Ожидалось исключение, но оно не было выброшено');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), contains('Ошибка удаления привычки'));
      }
    });

    test('Update habit from local datasource', () async {
      when(habitsDao.updateHabit(
        any,
        title: anyNamed('title'),
        description: anyNamed('description'),
        categoryId: anyNamed('categoryId'),
        steps: anyNamed('steps'),
        isActive: anyNamed('isActive'),
        lastTimeCompleted: anyNamed('lastTimeCompleted'),
        isPendingSync: anyNamed('isPendingSync'),
        syncStatus: anyNamed('syncStatus'),
      )).thenAnswer((_) async => Future.value(1));

      await localDatasource.updateHabit(testHabit);

      final verification = verify(habitsDao.updateHabit(
        captureAny,
        title: captureAnyNamed('title'),
        description: captureAnyNamed('description'),
        categoryId: captureAnyNamed('categoryId'),
        steps: captureAnyNamed('steps'),
        isActive: captureAnyNamed('isActive'),
        lastTimeCompleted: captureAnyNamed('lastTimeCompleted'),
        isPendingSync: captureAnyNamed('isPendingSync'),
        syncStatus: captureAnyNamed('syncStatus'),
      ));

      final capturedArgs = verification.captured;

      expect(capturedArgs[0], testHabit.id); // Проверяем id
      expect(capturedArgs[1], testHabit.title);
      expect(capturedArgs[2], testHabit.description);
      expect(capturedArgs[3], testHabit.categoryId);
      expect(capturedArgs[4], testHabit.steps);
      expect(capturedArgs[5], testHabit.isActive);
      expect((capturedArgs[6] as DateTime).toIso8601String(), testHabit.lastCompletedDate);
      expect(capturedArgs[7], true);
      expect(capturedArgs[8], 'update');
    });

    test('Marking habits as pending with sync status', () async {
      when(habitsDao.updateHabit(
        any,
        syncStatus: anyNamed('syncStatus'),
        isPendingSync: anyNamed('isPendingSync'),
        title: anyNamed('title'),
        description: anyNamed('description'),
        categoryId: anyNamed('categoryId'),
        steps: anyNamed('steps'),
        isActive: anyNamed('isActive'),
        lastTimeCompleted: anyNamed('lastTimeCompleted'),
      )).thenAnswer((_) async => Future.value(1));

      await localDatasource.markHabitAsPendingSync('1', SyncStatus.add);
      await localDatasource.markHabitAsPendingSync('1', SyncStatus.update);
      await localDatasource.markHabitAsPendingSync('1', SyncStatus.delete);
      await localDatasource.markHabitAsPendingSync('1', SyncStatus.synced);

      final verification = verify(habitsDao.updateHabit(
        captureAny,
        syncStatus: captureAnyNamed('syncStatus'),
        isPendingSync: captureAnyNamed('isPendingSync'),
        title: anyNamed('title'),
        description: anyNamed('description'),
        categoryId: anyNamed('categoryId'),
        steps: anyNamed('steps'),
        isActive: anyNamed('isActive'),
        lastTimeCompleted: anyNamed('lastTimeCompleted'),
      ));

      final capturedArgs = verification.captured;

      // Check the number of captured arguments
      expect(capturedArgs.length, 12);

      // Check the captured arguments
      expect(capturedArgs[0], '1');
      expect(capturedArgs[1], 'add');
      expect(capturedArgs[2], true);
      expect(capturedArgs[3], '1');
      expect(capturedArgs[4], 'update');
      expect(capturedArgs[5], true);
      expect(capturedArgs[6], '1');
      expect(capturedArgs[7], 'delete');
      expect(capturedArgs[8], true);
      expect(capturedArgs[9], '1');
      expect(capturedArgs[10], 'synced');
      expect(capturedArgs[11], true);

      // Check the number of calls
      expect(verification.callCount, 4);
    });

    test('Marking habit as synced', () async {
      when(habitsDao.updateHabit(
        any,
        syncStatus: anyNamed('syncStatus'),
        isPendingSync: anyNamed('isPendingSync'),
        title: anyNamed('title'),
        description: anyNamed('description'),
        categoryId: anyNamed('categoryId'),
        steps: anyNamed('steps'),
        isActive: anyNamed('isActive'),
        lastTimeCompleted: anyNamed('lastTimeCompleted'),
      )).thenAnswer((_) async => Future.value(1));

      await localDatasource.markHabitAsSynced('1');

      final verification = verify(habitsDao.updateHabit(
        captureAny,
        syncStatus: captureAnyNamed('syncStatus'),
        isPendingSync: captureAnyNamed('isPendingSync'),
        title: anyNamed('title'),
        description: anyNamed('description'),
        categoryId: anyNamed('categoryId'),
        steps: anyNamed('steps'),
        isActive: anyNamed('isActive'),
        lastTimeCompleted: anyNamed('lastTimeCompleted'),
      ));

      final capturedArgs = verification.captured;

      expect(capturedArgs[0], '1');
      expect(capturedArgs[1], 'synced');
      expect(capturedArgs[2], false);
    });
  });

  //Group for Remote Datasource
  group('Habits Remote DataSource', () {
    test('Get habits', () async {
      when(remoteDataSource.getHabits())
          .thenAnswer((_) async => Future.value([testHabit, testHabit.copyWith(id: '2')]));

      final habits = await remoteDataSource.getHabits();

      expect(habits.length, 2);
      expect(habits[0].id, '1');
      expect(habits[1].id, '2');

      verify(remoteDataSource.getHabits()).called(1);
    });

    test('Get habit by id', () async {
      when(remoteDataSource.getHabitById(any)).thenAnswer((_) async => Future.value(testHabit));

      final habit = await remoteDataSource.getHabitById('1');

      expect(habit, testHabit);

      verify(remoteDataSource.getHabitById('1')).called(1);
    });

    test('Add habit', () async {
      when(remoteDataSource.addHabit(any)).thenAnswer((_) async => Future.value());

      await remoteDataSource.addHabit(testHabit);

      final verification = verify(remoteDataSource.addHabit(captureAny));

      final capturedArgs = verification.captured;

      expect(capturedArgs.first, testHabit);

      expect(verification.callCount, 1);
    });

    test('Update habit', () async {
      when(remoteDataSource.updateHabit(any)).thenAnswer((_) async => Future.value());

      await remoteDataSource.updateHabit(testHabit);

      final verification = verify(remoteDataSource.updateHabit(captureAny));

      final capturedArgs = verification.captured;

      expect(capturedArgs.first, testHabit);

      expect(verification.callCount, 1);
    });

    test('Delete habit', () async {
      when(remoteDataSource.deleteHabit(any)).thenAnswer((_) async => Future.value());

      await remoteDataSource.deleteHabit('1');

      final verification = verify(remoteDataSource.deleteHabit(captureAny));

      final capturedArgs = verification.captured;

      expect(capturedArgs.first, '1');

      expect(verification.callCount, 1);
    });
  });

  group('Habits Repository Implementation Tests', () {
    group('With Internet connection', () {
      test('Get habits with same objects', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.getHabits())
            .thenAnswer((_) async => Future.value([testHabit, testHabit.copyWith(id: '2')]));
        when(remoteDataSource.getHabits())
            .thenAnswer((_) async => Future.value([testHabit, testHabit.copyWith(id: '2')]));

        final habits = await habitsRepository.getHabits();

        expect(habits.length, 2);
        expect(habits[0].id, '1');
        expect(habits[1].id, '2');

        verify(localDataSource.getHabits()).called(2);
        verify(remoteDataSource.getHabits()).called(1);
      });

      test('Remote habit is newer,should update local', () async {
        final oldLocalHabit = testHabit.copyWith(id: '1', updatedAt: DateTime(2024, 2, 20).toIso8601String());
        final newLocalHabit =
            testHabit.copyWith(id: '1', updatedAt: DateTime(2024, 2, 25).toIso8601String()); // после обновления

        final remoteHabit = testHabit.copyWith(
            id: '1',
            updatedAt:
                DateTime(2024, 2, 22).toIso8601String()); // Новее, чем `oldLocalHabit`, но старее `newLocalHabit`

        when(appConnect.hasConnect()).thenAnswer((_) async => true);

        // Первый вызов вернет `oldLocalHabit`, второй вызов - `newLocalHabit`
        int getHabitsCallCount = 0;
        when(localDataSource.getHabits()).thenAnswer((_) async {
          if (getHabitsCallCount == 0) {
            getHabitsCallCount++;
            return [oldLocalHabit];
          } else {
            return [newLocalHabit];
          }
        });

        when(remoteDataSource.getHabits()).thenAnswer((_) async => [remoteHabit]);

        final habits = await habitsRepository.getHabits();

        expect(habits.length, 1);
        expect(habits[0].updatedAt, newLocalHabit.updatedAt);

        verify(localDataSource.getHabits()).called(2);
        verify(remoteDataSource.getHabits()).called(1);
      });

      test('Local habit is newer, should update remote', () async {
        final localHabit = testHabit.copyWith(id: '1', updatedAt: '2023-11-25T14:30:45.123456Z');
        final remoteHabit =
            testHabit.copyWith(id: '1', updatedAt: '2023-11-22T14:30:45.123456Z'); // более старая версия

        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.getHabits()).thenAnswer((_) async => Future.value([localHabit]));
        when(remoteDataSource.getHabits()).thenAnswer((_) async => Future.value([remoteHabit]));

        final habits = await habitsRepository.getHabits();

        expect(habits.length, 1);
        expect(habits[0].updatedAt, localHabit.updatedAt); // Должна остаться локальная версия

        verify(localDataSource.getHabits()).called(2);
        verify(remoteDataSource.getHabits()).called(1);
        verify(remoteDataSource.updateHabit(localHabit)).called(1);
        verify(localDataSource.markHabitAsSynced(localHabit.id)).called(1);
      });

      test('Local habit is missing, should save from remote', () async {
        final remoteHabit = testHabit.copyWith(id: '3');

        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        int getHabitsCallCount = 0;
        when(localDataSource.getHabits()).thenAnswer((_) async {
          if (getHabitsCallCount == 0) {
            getHabitsCallCount++;
            return [];
          } else {
            return [remoteHabit];
          }
        });
        when(remoteDataSource.getHabits()).thenAnswer((_) async => Future.value([remoteHabit]));

        final habits = await habitsRepository.getHabits();

        expect(habits.length, 1);
        expect(habits[0].id, '3'); // Данные взяты с сервера

        verify(localDataSource.getHabits()).called(2);
        verify(remoteDataSource.getHabits()).called(1);
        verify(localDataSource.saveHabit(remoteHabit)).called(1);
      });

      test('Remote habit deleted, should delete locally', () async {
        final localHabit = testHabit.copyWith(id: '4');

        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        int getHabitsCallCount = 0;
        when(localDataSource.getHabits()).thenAnswer((_) async {
          if (getHabitsCallCount == 0) {
            getHabitsCallCount++;
            return [localHabit];
          } else {
            return [];
          }
        });
        when(remoteDataSource.getHabits()).thenAnswer((_) async => Future.value([])); // На сервере удалили

        final habits = await habitsRepository.getHabits();

        expect(habits.isEmpty, true); // Локальная запись тоже должна быть удалена

        verify(localDataSource.getHabits()).called(2);
        verify(remoteDataSource.getHabits()).called(1);
        verify(localDataSource.deleteHabit(localHabit.id)).called(1);
      });

      test('Add Habit success', () async {
        when(localDataSource.saveHabit(any)).thenAnswer((_) async => Future.value());
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(remoteDataSource.addHabit(any)).thenAnswer((_) async => Future.value());
        when(localDataSource.markHabitAsSynced(any)).thenAnswer((_) async => Future.value());

        await habitsRepository.addHabit(testHabit);

        final verificationOnLocalSave = verify(await localDataSource.saveHabit(captureAny));
        verify(appConnect.hasConnect()).called(1);
        final verificationOnRemoteAdd = verify(await remoteDataSource.addHabit(captureAny));
        final verificationOnLocalMarkAsSynced = verify(localDataSource.markHabitAsSynced(captureAny));

        expect(verificationOnLocalSave.callCount, 1);
        expect(verificationOnLocalSave.captured.first.id, testHabit.id);

        expect(verificationOnRemoteAdd.callCount, 1);
        expect(verificationOnRemoteAdd.captured.first.id, testHabit.id);

        expect(verificationOnLocalMarkAsSynced.callCount, 1);
        expect(verificationOnLocalMarkAsSynced.captured.first, testHabit.id);
      });

      test('Add Habit remote error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.saveHabit(any)).thenAnswer((_) async => Future.value());
        when(remoteDataSource.addHabit(any)).thenThrow(Exception('Remote error'));
        when(localDataSource.markHabitAsPendingSync(any, any)).thenAnswer((_) async => Future.value());

        await habitsRepository.addHabit(testHabit);

        final verificationOnLocalSave = verify(await localDataSource.saveHabit(captureAny));
        verify(appConnect.hasConnect()).called(1);
        final verificationOnRemoteAdd = verify(await remoteDataSource.addHabit(captureAny));
        final verificationOnLocalMarkAsPendingSync =
            verify(localDataSource.markHabitAsPendingSync(captureAny, captureAny));

        expect(verificationOnLocalSave.callCount, 1);
        expect(verificationOnLocalSave.captured.first.id, testHabit.id);

        expect(verificationOnRemoteAdd.callCount, 1);
        expect(verificationOnRemoteAdd.captured.first.id, testHabit.id);

        expect(verificationOnLocalMarkAsPendingSync.callCount, 1);
        expect(verificationOnLocalMarkAsPendingSync.captured.first, testHabit.id);
        expect(verificationOnLocalMarkAsPendingSync.captured[1], SyncStatus.add);
      });

      test('Add Habit local error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.saveHabit(any)).thenThrow(Exception('Local error'));

        await expectLater(habitsRepository.addHabit(testHabit), throwsException);
      });

      test('Update Habit success', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.updateHabit(any)).thenAnswer((_) async => Future.value());
        when(remoteDataSource.updateHabit(any)).thenAnswer((_) async => Future.value());
        when(localDataSource.markHabitAsSynced(any)).thenAnswer((_) async => Future.value());

        await habitsRepository.updateHabit(testHabit);

        final verificationOnLocalUpdate = verify(await localDataSource.updateHabit(captureAny));
        verify(appConnect.hasConnect()).called(1);
        final verificationOnRemoteUpdate = verify(await remoteDataSource.updateHabit(captureAny));
        final verificationOnLocalMarkAsSynced = verify(localDataSource.markHabitAsSynced(captureAny));

        expect(verificationOnLocalUpdate.callCount, 1);
        expect(verificationOnLocalUpdate.captured.first.id, testHabit.id);

        expect(verificationOnRemoteUpdate.callCount, 1);
        expect(verificationOnRemoteUpdate.captured.first.id, testHabit.id);

        expect(verificationOnLocalMarkAsSynced.callCount, 1);
        expect(verificationOnLocalMarkAsSynced.captured.first, testHabit.id);
      });

      test('Update Habit remote error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.updateHabit(any)).thenAnswer((_) async => Future.value());
        when(remoteDataSource.updateHabit(any)).thenThrow(Exception('Remote error'));
        when(localDataSource.markHabitAsPendingSync(any, any)).thenAnswer((_) async => Future.value());

        await habitsRepository.updateHabit(testHabit);

        final verificationOnLocalUpdate = verify(await localDataSource.updateHabit(captureAny));
        verify(appConnect.hasConnect()).called(1);
        final verificationOnRemoteUpdate = verify(await remoteDataSource.updateHabit(captureAny));
        final verificationOnLocalMarkAsPendingSync =
            verify(localDataSource.markHabitAsPendingSync(captureAny, captureAny));

        expect(verificationOnLocalUpdate.callCount, 1);
        expect(verificationOnLocalUpdate.captured.first.id, testHabit.id);

        expect(verificationOnRemoteUpdate.callCount, 1);
        expect(verificationOnRemoteUpdate.captured.first.id, testHabit.id);

        expect(verificationOnLocalMarkAsPendingSync.callCount, 1);
        expect(verificationOnLocalMarkAsPendingSync.captured.first, testHabit.id);
        expect(verificationOnLocalMarkAsPendingSync.captured[1], SyncStatus.update);
      });

      test('Update Habit local error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.updateHabit(any)).thenThrow(Exception('Local error'));

        await expectLater(habitsRepository.updateHabit(testHabit), throwsException);
      });

      test('Delete Habit success', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.deleteHabit(any)).thenAnswer((_) async => Future.value());
        when(remoteDataSource.deleteHabit(any)).thenAnswer((_) async => Future.value());

        await habitsRepository.deleteHabit(testHabit.id);

        final verificationOnLocalDelete = verify(await localDataSource.deleteHabit(captureAny));
        verify(appConnect.hasConnect()).called(1);
        final verificationOnRemoteDelete = verify(await remoteDataSource.deleteHabit(captureAny));

        expect(verificationOnLocalDelete.callCount, 1);
        expect(verificationOnLocalDelete.captured.first, testHabit.id);

        expect(verificationOnRemoteDelete.callCount, 1);
        expect(verificationOnRemoteDelete.captured.first, testHabit.id);
      });

      test('Delete Habit remote error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(true));
        when(localDataSource.deleteHabit(any)).thenAnswer((_) async => Future.value());
        when(remoteDataSource.deleteHabit(any)).thenThrow(Exception('Remote error'));

        await expectLater(habitsRepository.deleteHabit(testHabit.id), throwsException);
      });
    });

    group('Without Internet Connection', () {
      test('Get habits', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(false));
        when(localDataSource.getHabits()).thenAnswer((_) async => Future.value([testHabit]));

        final habits = await habitsRepository.getHabits();

        verify(appConnect.hasConnect()).called(1);
        verify(localDataSource.getHabits()).called(1);

        expect(habits, [testHabit]);
      });

      test('Get Habit with Error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(false));
        when(localDataSource.getHabits()).thenThrow(Exception('Local error'));

        await expectLater(habitsRepository.getHabits(), throwsException);
      });

      test('Add Habit success', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => Future.value(false));
        when(localDataSource.saveHabit(any)).thenAnswer((_) async => Future.value());
        when(localDataSource.markHabitAsPendingSync(testHabit.id, SyncStatus.add))
            .thenAnswer((_) async => Future.value());

        await habitsRepository.addHabit(testHabit);

        final verificationOnLocalSave = verify(await localDataSource.saveHabit(captureAny));
        verify(appConnect.hasConnect()).called(1);
        final verificationOnLocalMarkAsPendingSync =
            verify(localDataSource.markHabitAsPendingSync(captureAny, captureAny));

        expect(verificationOnLocalSave.callCount, 1);
        expect(verificationOnLocalSave.captured.first.id, testHabit.id);

        expect(verificationOnLocalMarkAsPendingSync.callCount, 1);
        expect(verificationOnLocalMarkAsPendingSync.captured.first, testHabit.id);
        expect(verificationOnLocalMarkAsPendingSync.captured[1], SyncStatus.add);
      });

      test('Add Habit local error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => false);
        when(localDataSource.saveHabit(any)).thenThrow(Exception('Local error'));

        await expectLater(habitsRepository.addHabit(testHabit), throwsException);
      });

      test('Update Habit success', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => false);
        when(localDataSource.updateHabit(any)).thenAnswer((_) async => Future.value());
        when(localDataSource.markHabitAsPendingSync(any, any)).thenAnswer((_) async => Future.value());

        await habitsRepository.updateHabit(testHabit);

        final verificationOnLocalUpdate = verify(localDataSource.updateHabit(captureAny));
        verify(appConnect.hasConnect()).called(1);
        final verificationOnLocalMarkAsPendingSync =
            verify(localDataSource.markHabitAsPendingSync(captureAny, captureAny));

        expect(verificationOnLocalUpdate.callCount, 1);
        expect(verificationOnLocalUpdate.captured.first.id, testHabit.id);

        expect(verificationOnLocalMarkAsPendingSync.callCount, 1);
        expect(verificationOnLocalMarkAsPendingSync.captured.first, testHabit.id);
        expect(verificationOnLocalMarkAsPendingSync.captured[1], SyncStatus.update);
      });

      test('Update Habit local error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => false);
        when(localDataSource.updateHabit(any)).thenThrow(Exception('Local error'));

        await expectLater(habitsRepository.updateHabit(testHabit), throwsException);
      });

      test('Delete Habit success', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => false);
        when(localDataSource.markHabitAsPendingSync(any, any)).thenAnswer((_) async => Future.value());

        await habitsRepository.deleteHabit(testHabit.id);

        verify(appConnect.hasConnect()).called(1);
        final verificationOnLocalMarkAsPendingSync =
            verify(localDataSource.markHabitAsPendingSync(captureAny, captureAny));

        expect(verificationOnLocalMarkAsPendingSync.callCount, 1);
        expect(verificationOnLocalMarkAsPendingSync.captured.first, testHabit.id);
        expect(verificationOnLocalMarkAsPendingSync.captured[1], SyncStatus.delete);
      });

      test('Delete Habit local error', () async {
        when(appConnect.hasConnect()).thenAnswer((_) async => false);
        when(localDataSource.markHabitAsPendingSync(any, any)).thenThrow(Exception('Local error'));

        await expectLater(habitsRepository.deleteHabit(testHabit.id), throwsException);
      });
    });

    // group('HabitBloc tests', () {
    //   late MockIHabitRepository mockHabitsRepository;
    //   late HabitsBloc habitsBloc;

    //   setUp(() {
    //     mockHabitsRepository = MockIHabitRepository();
    //     habitsBloc = HabitsBloc(mockHabitsRepository);

    //     // Имитируем поток привычек, чтобы подписка в конструкторе блока не выбрасывала ошибку
    //     when(mockHabitsRepository.watchHabits()).thenAnswer((_) => Stream<List<HabitEntity>>.fromIterable([
    //           [testHabit]
    //         ]));
    //   });

    //   tearDown(() {
    //     habitsBloc.close();
    //     mockHabitsRepository.dispose();
    //   });

    //   blocTest<HabitsBloc, HabitsState>(
    //     'InitializeHabits event should emit HabitsLoadSuccess state',
    //     build: () {
    //       when(mockHabitsRepository.getHabits()).thenAnswer((_) async => [testHabit]);
    //       return habitsBloc;
    //     },
    //     act: (bloc) => bloc.add(InitializeHabits()),
    //     expect: () => [
    //       isA<HabitsLoadSuccess>().having((state) => state.habits, 'habits', equals([testHabit]))
    //     ],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'InitializeHabits event should emit HabitsOperationFailure state',
    //     build: () {
    //       when(mockHabitsRepository.getHabits()).thenThrow(Exception('Error'));
    //       return habitsBloc;
    //     },
    //     act: (bloc) => bloc.add(InitializeHabits()),
    //     expect: () => [isA<HabitsOperationFailure>()],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'LoadHabits event should emit HabitsLoadSuccess state',
    //     build: () => habitsBloc,
    //     act: (bloc) => bloc.add(LoadHabits([testHabit])),
    //     expect: () => [
    //       isA<HabitsLoadSuccess>().having((state) => state.habits, 'habits', equals([testHabit]))
    //     ],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'AddHabit event should emit HabitsOperationSuccess state',
    //     build: () => habitsBloc,
    //     act: (bloc) =>
    //         bloc.add(AddHabit(testHabit.title, testHabit.description ?? '', testHabit.frequency, testHabit.priority)),
    //     expect: () => [
    //       isA<HabitsOperationSuccess>().having(
    //         (state) => state.message,
    //         'message',
    //         equals('Habit is added'),
    //       ),
    //     ],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'AddHabit event with empty title and description should emit HabitsOperationFailure state',
    //     build: () => habitsBloc,
    //     act: (bloc) => bloc.add(AddHabit('', testHabit.description ?? '', testHabit.frequency, testHabit.priority)),
    //     expect: () => [
    //       isA<HabitsOperationFailure>().having(
    //         (state) => state.error,
    //         'error',
    //         equals('Please enter title and description'),
    //       ),
    //     ],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'AddHabit event should emit HabitsOperationFailure state',
    //     build: () {
    //       when(mockHabitsRepository.addHabit(any)).thenThrow(Exception('Error'));
    //       return habitsBloc;
    //     },
    //     act: (bloc) =>
    //         bloc.add(AddHabit(testHabit.title, testHabit.description ?? '', testHabit.frequency, testHabit.priority)),
    //     expect: () => [isA<HabitsOperationFailure>()],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'DeleteHabit event should emit HabitsOperationSuccess state',
    //     build: () => habitsBloc,
    //     act: (bloc) => bloc.add(DeleteHabit(testHabit.id)),
    //     expect: () => [
    //       isA<HabitsOperationSuccess>().having(
    //         (state) => state.message,
    //         'message',
    //         equals('Habit is deleted'),
    //       ),
    //     ],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'DeleteHabit event should emit HabitsOperationFailure state',
    //     build: () {
    //       when(mockHabitsRepository.deleteHabit(any)).thenThrow(Exception('Error'));
    //       return habitsBloc;
    //     },
    //     act: (bloc) => bloc.add(DeleteHabit(testHabit.id)),
    //     expect: () => [isA<HabitsOperationFailure>()],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'UpdateHabit event should emit HabitsOperationSuccess state',
    //     build: () {
    //       when(mockHabitsRepository.updateHabit(any)).thenAnswer((_) async => Future.value());
    //       return habitsBloc;
    //     },
    //     seed: () => HabitsLoadSuccess([testHabit]),
    //     act: (bloc) => bloc.add(
    //       UpdateHabit(
    //         testHabit.id,
    //         'Updated Title',
    //         'Updated Description',
    //         testHabit.frequency,
    //         testHabit.priority,
    //       ),
    //     ),
    //     expect: () => [
    //       isA<HabitsOperationSuccess>()
    //           .having((state) => state.message, 'message', equals('Habit is updated'))
    //           .having((state) => state.habits, 'habits', equals([testHabit])),
    //     ],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'UpdateHabit event should emit HabitsOperationFailure state',
    //     build: () {
    //       when(mockHabitsRepository.updateHabit(any)).thenThrow(Exception('Error'));
    //       return habitsBloc;
    //     },
    //     seed: () => HabitsLoadSuccess([testHabit]),
    //     act: (bloc) => bloc.add(
    //       UpdateHabit(
    //         testHabit.id,
    //         'Updated Title',
    //         'Updated Description',
    //         testHabit.frequency,
    //         testHabit.priority,
    //       ),
    //     ),
    //     expect: () => [isA<HabitsOperationFailure>()],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'FinishHabit event should emit HabitsOperationSuccess state',
    //     build: () {
    //       when(mockHabitsRepository.updateHabit(any)).thenAnswer((_) async => Future.value());
    //       return habitsBloc;
    //     },
    //     seed: () => HabitsLoadSuccess([testHabit]),
    //     act: (bloc) => bloc.add(FinishHabit(testHabit.id)),
    //     expect: () => [
    //       isA<HabitsOperationSuccess>()
    //           .having(
    //             (state) => state.message,
    //             'message',
    //             equals('Habit is finished'),
    //           )
    //           .having((state) => state.habits, 'habits', equals([testHabit])),
    //     ],
    //   );

    //   blocTest<HabitsBloc, HabitsState>(
    //     'FinishHabit event should emit HabitsOperationFailure state',
    //     build: () {
    //       when(mockHabitsRepository.updateHabit(any)).thenThrow(Exception('Error'));
    //       return habitsBloc;
    //     },
    //     seed: () => HabitsLoadSuccess([testHabit]),
    //     act: (bloc) => bloc.add(FinishHabit(testHabit.id)),
    //     expect: () => [isA<HabitsOperationFailure>()],
    //   );
    // });
  });
}
