import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'dao/habits_dao.dart';
import 'tables/habit_categories.dart';
import 'tables/habits.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [Habits, HabitCategories], daos: [HabitsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //       onCreate: (Migrator m) async {
  //         await m.createAll();
  //       },
  //       onUpgrade: (Migrator m, int from, int to) async {
  // await m.deleteTable('habits');
  // final result = await customSelect("PRAGMA table_info(habits);").get();
  // final columnNames = result.map((row) => row.data['name'] as String).toList();
  // if (!columnNames.contains("sync_status")) {
  //   await m.addColumn(habits, habits.syncStatus);
  // }
  //   },
  // );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'drift_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
