import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:go_habit/core/database/dao/habits_dao.dart';
import 'package:go_habit/core/database/tables/habit_categories.dart';
import 'package:go_habit/core/database/tables/habit_completions.dart';
import 'package:go_habit/core/database/tables/habit_streaks.dart';
import 'package:go_habit/core/database/tables/habits.dart';
import 'package:path_provider/path_provider.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [Habits, HabitCategories, HabitCompletions, HabitStreaks], daos: [HabitsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        // // Добавляем триггеры
        // await customStatement('''
        //   CREATE TRIGGER IF NOT EXISTS on_habit_last_completed_update
        //   AFTER UPDATE OF last_completed_time ON habits
        //   FOR EACH ROW
        //   BEGIN
        //     -- При установке нового времени выполнения
        //     DELETE FROM habit_completions
        //     WHERE habit_id = NEW.id
        //       AND date(date_complete) = date(NEW.last_completed_time);

        //     -- Добавляем новую запись только если время установлено
        //     INSERT INTO habit_completions (habit_id, user_id, date_complete)
        //     SELECT NEW.id, NEW.user_id, date(NEW.last_completed_time)
        //     WHERE NEW.last_completed_time IS NOT NULL;

        //     -- При сбросе времени выполнения (NULL)
        //     DELETE FROM habit_completions
        //     WHERE id IN (
        //       SELECT id FROM habit_completions
        //       WHERE habit_id = NEW.id
        //       ORDER BY date_complete DESC
        //       LIMIT 1
        //     ) AND NEW.last_completed_time IS NULL;
        //   END;
        // ''');
      },
      onUpgrade: (m, from, to) async {
        // if (from < 2) {
        //   // Добавляем триггер при обновлении базы
        //   await customStatement('''
        //     CREATE TRIGGER IF NOT EXISTS on_habit_last_completed_update
        //     AFTER UPDATE OF last_completed_time ON habits
        //     FOR EACH ROW
        //     BEGIN
        //       -- Тот же код триггера, что и в onCreate
        //       DELETE FROM habit_completions
        //       WHERE habit_id = NEW.id
        //         AND date(date_complete) = date(NEW.last_completed_time);

        //       INSERT INTO habit_completions (habit_id, user_id, date_complete)
        //       SELECT NEW.id, NEW.user_id, date(NEW.last_completed_time)
        //       WHERE NEW.last_completed_time IS NOT NULL;

        //       DELETE FROM habit_completions
        //       WHERE id IN (
        //         SELECT id FROM habit_completions
        //         WHERE habit_id = NEW.id
        //         ORDER BY date_complete DESC
        //         LIMIT 1
        //       ) AND NEW.last_completed_time IS NULL;
        //     END;
        //   ''');
        // }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'drift_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
