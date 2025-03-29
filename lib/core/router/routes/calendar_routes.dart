part of '../app_router.dart';

final _calendarRoutes = [
  GoRoute(
    parentNavigatorKey: _calendarRoutesNavigatorKey,
    path: CalendarRoutes.calendar.path,
    name: CalendarRoutes.calendar.name,
    builder: (_, state) => CalendarPage(key: state.pageKey),
  ),
];
