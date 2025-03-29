part of '../app_router.dart';

final _homeRoutes = [
  GoRoute(
    parentNavigatorKey: _homeRoutesNavigatorKey,
    path: HomeRoutes.home.path,
    name: HomeRoutes.home.name,
    builder: (_, state) => HomePage(key: state.pageKey),
    routes: [
      GoRoute(
        path: HomeRoutes.tasks.path,
        name: HomeRoutes.tasks.name,
        builder: (_, state) => TasksPage(key: state.pageKey),
      ),
    ],
  ),
];
