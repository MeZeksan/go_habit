part of '../app_router.dart';

final _homeRoutes = [
  GoRoute(
    path: HomeRoutes.home.path,
    name: HomeRoutes.home.name,
    builder: (_, state) => Placeholder(key: state.pageKey),
    routes: [
      GoRoute(
        path: HomeRoutes.tasks.path,
        name: HomeRoutes.tasks.name,
        builder: (_, state) => Placeholder(key: state.pageKey),
      ),
    ],
  ),
];
