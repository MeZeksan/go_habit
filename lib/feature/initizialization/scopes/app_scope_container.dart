import 'package:go_habit/core/app_connect/src/app_connect.dart';
import 'package:go_habit/core/database/dao/habit_category_dao.dart';
import 'package:go_habit/core/database/dao/habit_completion_dao.dart';
import 'package:go_habit/core/database/dao/habit_streak_dao.dart';
import 'package:go_habit/core/database/dao/habits_dao.dart';
import 'package:go_habit/core/database/drift_database.dart';
import 'package:go_habit/core/router/app_router.dart';
import 'package:go_habit/feature/auth/data/repositories/authentication_repository.dart';
import 'package:go_habit/feature/auth/domain/repositories/i_authentication_repository.dart';
import 'package:go_habit/feature/categories/data/data_sources/local/local_habit_category_datasource.dart';
import 'package:go_habit/feature/categories/data/data_sources/remote/remote_habit_category_datasource.dart';
import 'package:go_habit/feature/categories/data/repositories/habit_category_repository_implementation.dart';
import 'package:go_habit/feature/categories/domain/repositories/habit_category_repository.dart';
import 'package:go_habit/feature/habit_stats/data/data_sources/local/local_habit_stats_datasource.dart';
import 'package:go_habit/feature/habit_stats/data/data_sources/remote/remote_habit_stats_datasource.dart';
import 'package:go_habit/feature/habit_stats/data/repositories/habit_stats_repository_implementation.dart';
import 'package:go_habit/feature/habit_stats/domain/repositories/habit_stats_repository.dart';
import 'package:go_habit/feature/habits/data/data_sources/local/local_habit_data_source.dart';
import 'package:go_habit/feature/habits/data/data_sources/remote/remote_habit_data_source.dart';
import 'package:go_habit/feature/habits/data/repositories/habit_repository_implementation.dart';
import 'package:go_habit/feature/habits/domain/repositories/habit_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yx_scope/yx_scope.dart';

class AppScopeContainer extends ScopeContainer {
  late final appConnect = dep(() => const AppConnect());
  late final appDatabase = dep<AppDatabase>(AppDatabase.new);

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

  late final localHabitStatsDataSource = dep<LocalHabitStatsDataSource>(
      () => LocalStatsDataSourceImpl(HabitCompletionDao(appDatabase.get), HabitStreakDao(appDatabase.get)));

  late final remoteHabitStatsDataSource = dep<RemoteHabitStatsDataSource>(
    () => SupabaseHabitsStatsDataSource(Supabase.instance.client),
  );

  late final habitStatsRepository = dep<HabitStatsRepository>(
    () => HabitStatsRepositoryImplementation(
        localHabitStatsDataSource.get, remoteHabitStatsDataSource.get, appConnect.get),
  );

  //  LocalHabitStatsDataSource(),
  //               RemoteHabitStatsDataSource(),
  //               const AppConnect(),

  late final authRepositoryDep = dep<IAuthenticationRepository>(AuthenticationRepository.new);

  late final habitRepositoryDep = dep<HabitRepository>(
      () => HabitsRepositoryImplementation(localHabitDataSource.get, remoteHabitDataSource.get, appConnect.get));

  late final habitCategoriesRepositoryDep = dep<HabitCategoryRepository>(() => HabitCategoryRepositoryImplementation(
      localHabitCategoryDataSource.get, remoteHabitCategoryDataSource.get, appConnect.get));

  late final routerConfig = dep(() => AppRouter().routerConfig);
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() {
    return AppScopeContainer();
  }
}
