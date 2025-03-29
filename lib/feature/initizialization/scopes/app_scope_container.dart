import 'package:flutter/material.dart';
import 'package:go_habit/core/app_connect/src/app_connect.dart';
import 'package:go_habit/core/database/dao/habits_dao.dart';
import 'package:go_habit/core/database/drift_database.dart';
import 'package:go_habit/feature/auth/data/repositories/authentication_repository.dart';
import 'package:go_habit/feature/auth/domain/repositories/i_authentication_repository.dart';
import 'package:go_habit/feature/habits/data/repositories/habit_repository_implementation.dart';
import 'package:go_habit/feature/habits/domain/repositories/habit_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yx_scope/yx_scope.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../habits/data/data_sources/local/local_habit_data_source.dart';
import '../../habits/data/data_sources/remote/remote_habit_data_source.dart';

class AppScopeContainer extends ScopeContainer {
  late final localHabitDataSource = dep<LocalHabitDataSource>(
    () => DriftHabitDataSource(HabitsDao(AppDatabase())),
  );

  late final remoteHabitDataSource =
      dep<RemoteHabitDataSource>(() => SupabaseHabitDataSource(Supabase.instance.client));

  late final authRepositoryDep = dep<IAuthenticationRepository>(() => AuthenticationRepository());

  late final habitRepositoryDep = dep<HabitRepository>(
      () => HabitsRepositoryImplementation(localHabitDataSource.get, remoteHabitDataSource.get, const AppConnect()));

  late final routerConfigDep = dep<RouterConfig<Object>>(() => GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => Scaffold(
                body: Center(
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () => context.go('/home'),
              ),
            )),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => ScopeBuilder<AppScopeContainer>.withPlaceholder(
                builder: (context, appScope) => Scaffold(
                        body: Center(
                      child: ElevatedButton(
                          onPressed: () => appScope.authRepositoryDep.get
                              .signInWithEmail(email: 'fzKl9@example.com', password: 'password'),
                          child: const Text('Home')),
                    )),
                placeholder: const Placeholder()),
          ),
        ],
      ));
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}
