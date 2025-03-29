part of '../app_router.dart';

final _calendarRoutes = [
  GoRoute(
    path: CalendarRoutes.calendar.path,
    name: CalendarRoutes.calendar.name,
    builder: (_, state) => HabitsPage(key: state.pageKey),
  ),
];
