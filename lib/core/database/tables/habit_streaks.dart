import 'package:drift/drift.dart';
import 'package:go_habit/core/database/tables/habits.dart';

@DataClassName('HabitStreak')
class HabitStreaks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get habitId => text().references(Habits, #id)();
  IntColumn get currentStreak => integer()();
  DateTimeColumn get lastUpdate => dateTime()();

  // @override
  // Set<Column> get primaryKey => {id};
}
