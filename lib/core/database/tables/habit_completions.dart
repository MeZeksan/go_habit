import 'package:drift/drift.dart';
import 'package:go_habit/core/database/tables/habits.dart';

@DataClassName('HabitCompletion')
class HabitCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get habitId => text().references(Habits, #id)();
  DateTimeColumn get dateComplete => dateTime()();

  // @override
  // Set<Column> get primaryKey => {id};
}
