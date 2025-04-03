import 'package:drift/drift.dart';
import 'package:go_habit/core/database/dao/habit_category_dao.dart';
import 'package:go_habit/core/database/drift_database.dart' as drift;
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:meta/meta.dart';

abstract interface class LocalHabitCategoryDatasource {
  Future<List<HabitCategory>> getHabitCategories();

  Future<void> saveAllCategories(List<HabitCategory> categories);
}

@reopen
class DriftHabitCategoryDataSource extends LocalHabitCategoryDatasource {
  final HabitCategoryDao _habitCategoryDao;

  DriftHabitCategoryDataSource(this._habitCategoryDao);

  @override
  Future<List<HabitCategory>> getHabitCategories() async {
    final categories = await _habitCategoryDao.getAllCategories();
    return categories.map(HabitCategory.fromDriftModel).toList();
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
