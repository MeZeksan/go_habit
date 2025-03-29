part of '../app_router.dart';

final _notificationRoutes = [
  GoRoute(
    path: NotificationsRoutes.notifications.path,
    name: NotificationsRoutes.notifications.name,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
];
