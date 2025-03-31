part of '../app_router.dart';

final _homeRoutes = [
  GoRoute(
    parentNavigatorKey: _homeRoutesNavigatorKey,
    path: HomeRoutes.home.path,
    name: HomeRoutes.home.name,
    builder: (_, state) => const Center(
      child: Text('Home Screen'),
    ),
  ),
];
