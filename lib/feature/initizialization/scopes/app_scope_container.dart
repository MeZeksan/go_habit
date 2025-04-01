import 'package:go_habit/core/app_connect/src/app_connect.dart';
import 'package:go_habit/core/database/dao/habit_category_dao.dart';
import 'package:go_habit/core/database/dao/habits_dao.dart';
import 'package:go_habit/core/database/drift_database.dart';
import 'package:go_habit/feature/auth/data/repositories/authentication_repository.dart';
import 'package:go_habit/feature/auth/domain/repositories/i_authentication_repository.dart';
import 'package:go_habit/feature/categories/data/data_sources/local/local_habit_category_datasource.dart';
import 'package:go_habit/feature/categories/data/data_sources/remote/remote_habit_category_datasource.dart';
import 'package:go_habit/feature/categories/data/repositories/habit_category_repository_implementation.dart';
import 'package:go_habit/feature/categories/domain/repositories/habit_category_repository.dart';
import 'package:go_habit/feature/habits/data/repositories/habit_repository_implementation.dart';
import 'package:go_habit/feature/habits/domain/repositories/habit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yx_scope/yx_scope.dart';

import '../../../core/router/app_router.dart';
import '../../habits/data/data_sources/local/local_habit_data_source.dart';
import '../../habits/data/data_sources/remote/remote_habit_data_source.dart';

class AppScopeContainer extends ScopeContainer {
  late final appDatabase = dep<AppDatabase>(() => AppDatabase());

  late final localHabitDataSource = dep<LocalHabitDataSource>(
    () => DriftHabitDataSource(HabitsDao(appDatabase.get)),
  );

  late final remoteHabitDataSource =
      dep<RemoteHabitDataSource>(() => SupabaseHabitDataSource(Supabase.instance.client));

  late final localHabitCategoryDataSource = dep<LocalHabitCategoryDatasource>(
    () => DriftHabitCategoryDataSource(HabitCategoryDao(appDatabase.get)),
  );

  late final remoteHabitCategoryDataSource =
      dep<RemoteHabitCategoryDatasource>(() => SupabaseHabitCategoryDataSource(Supabase.instance.client));

  late final authRepositoryDep = dep<IAuthenticationRepository>(() => AuthenticationRepository());

  late final habitRepositoryDep = dep<HabitRepository>(
      () => HabitsRepositoryImplementation(localHabitDataSource.get, remoteHabitDataSource.get, const AppConnect()));

  late final habitCategoriesRepositoryDep = dep<HabitCategoryRepository>(() => HabitCategoryRepositoryImplementation(
      localHabitCategoryDataSource.get, remoteHabitCategoryDataSource.get, const AppConnect()));

  late final routerConfig = dep(() => AppRouter().routerConfig);
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() {
    return AppScopeContainer();
  }
}
