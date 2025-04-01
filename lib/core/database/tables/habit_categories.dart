import 'package:drift/drift.dart';

@DataClassName('HabitCategory')
class HabitCategories extends Table {
  TextColumn get id => text()(); // Строковый ID
  TextColumn get name => text()(); // Название категории
  TextColumn get color => text().withLength(min: 6, max: 7)(); // HEX-цвет

  @override
  Set<Column> get primaryKey => {id};
}
