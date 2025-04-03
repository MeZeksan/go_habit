part of '../app_router.dart';

final _profileRoutes = [
  GoRoute(
    parentNavigatorKey: _profileRoutesNavigatorKey,
    path: ProfileRoutes.profile.path,
    name: ProfileRoutes.profile.name,
    builder: (_, state) => ProfileScreen(
      key: state.pageKey,
    ),
  ),
  GoRoute(
    path: ProfileRoutes.settings.path,
    name: ProfileRoutes.settings.name,
    builder: (_, state) => const WidgetsSettingsScreen(),
  ),
];
