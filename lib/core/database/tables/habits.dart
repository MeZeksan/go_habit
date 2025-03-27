import 'package:drift/drift.dart';

@DataClassName('Habit')
class Habits extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get lastTimeCompleted => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get categoryId => integer().withDefault(const Constant(0))();
  BoolColumn get isPendingSync => boolean().withDefault(const Constant(false))();
  IntColumn get steps => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get syncStatus => text().withDefault(const Constant('add'))();
  TextColumn get icon => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}
