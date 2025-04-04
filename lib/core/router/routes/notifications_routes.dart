part of '../app_router.dart';

final _notificationRoutes = [
  GoRoute(
    parentNavigatorKey: _notificationRoutesBranchNavigatorKey,
    path: NotificationsRoutes.notifications.path,
    name: NotificationsRoutes.notifications.name,
    builder: (_, state) => NotificationsScreen(key: state.pageKey),
  ),
];
