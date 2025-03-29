part of '../app_router.dart';

final _profileRoutes = [
  GoRoute(
    path: ProfileRoutes.profile.path,
    name: ProfileRoutes.profile.name,
    builder: (_, state) => const Placeholder(),
  ),
  GoRoute(
    path: ProfileRoutes.settings.path,
    name: ProfileRoutes.settings.name,
    builder: (_, state) => const Placeholder(),
  ),
];
