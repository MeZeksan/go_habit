import 'package:drift/drift.dart';

import '../drift_database.dart';
import '../tables/habit_categories.dart';

part 'habit_category_dao.g.dart';

@DriftAccessor(tables: [HabitCategories])
class HabitCategoryDao extends DatabaseAccessor<AppDatabase> with _$HabitCategoryDaoMixin {
  HabitCategoryDao(super.db);

  // Получить все категории
  Future<List<HabitCategory>> getAllCategories() async {
    return await select(habitCategories).get();
  }

  // Найти категорию по ID
  Future<HabitCategory?> getCategoryById(String id) async {
    return await (select(habitCategories)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  // Добавить/обновить категорию
  Future<void> insertOrUpdateCategory(HabitCategory category) async {
    await into(habitCategories).insert(
      category,
      mode: InsertMode.insertOrReplace,
    );
  }

  // Удалить категорию
  Future<void> deleteCategory(String id) async {
    await (delete(habitCategories)..where((c) => c.id.equals(id))).go();
  }

  // Очистить все категории
  Future<void> clearCategories() async {
    await delete(habitCategories).go();
  }
}
