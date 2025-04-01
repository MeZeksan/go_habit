import 'package:drift/drift.dart';
import 'package:go_habit/core/database/drift_database.dart' as drift;

import '../../../../../core/database/dao/habit_category_dao.dart';
import '../../../domain/models/habit_category.dart';

abstract interface class LocalHabitCategoryDatasource {
  Future<List<HabitCategory>> getHabitCategories();

  Future<void> saveAllCategories(List<HabitCategory> categories);
}

class DriftHabitCategoryDataSource extends LocalHabitCategoryDatasource {
  final HabitCategoryDao _habitCategoryDao;

  DriftHabitCategoryDataSource(this._habitCategoryDao);

  @override
  Future<List<HabitCategory>> getHabitCategories() async {
    final categories = await _habitCategoryDao.getAllCategories();
    return categories.map((category) => HabitCategory.fromDriftModel(category)).toList();
  }

  @override
  Future<void> saveAllCategories(List<HabitCategory> categories) async {
    await _habitCategoryDao.batch((batch) {
      batch.insertAll(
        _habitCategoryDao.habitCategories,
        categories
            .map((batch) => drift.HabitCategoriesCompanion.insert(id: batch.id, name: batch.name, color: batch.color)),
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}
