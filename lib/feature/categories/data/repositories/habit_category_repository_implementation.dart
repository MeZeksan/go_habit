import 'package:go_habit/feature/categories/data/data_sources/local/local_habit_category_datasource.dart';
import 'package:go_habit/feature/categories/data/data_sources/remote/remote_habit_category_datasource.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';

import '../../../../core/app_connect/src/app_connect.dart';
import '../../domain/repositories/habit_category_repository.dart';

class HabitCategoryRepositoryImplementation implements HabitCategoryRepository {
  final LocalHabitCategoryDatasource _localHabitCategoryDatasource;
  final RemoteHabitCategoryDatasource _remoteHabitCategoryDatasource;
  final IAppConnect _appConnect;

  HabitCategoryRepositoryImplementation(
      this._localHabitCategoryDatasource, this._remoteHabitCategoryDatasource, this._appConnect);

  @override
  Future<List<HabitCategory>> getHabitCategories() async {
    try {
      if (await _appConnect.hasConnect()) {
        final remoteCategories = await _remoteHabitCategoryDatasource.getHabitCategories();

        if (remoteCategories.isNotEmpty) {
          await _localHabitCategoryDatasource.saveAllCategories(remoteCategories);
        }
      }
      return await _localHabitCategoryDatasource.getHabitCategories();
    } catch (error) {
      throw Exception('Exception on getHabitCategories');
    }
  }
}
