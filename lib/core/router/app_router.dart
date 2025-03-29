import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/root/presentation/pages/root_page.dart';
import 'routes_enum.dart';

part 'routes/auth_routes.dart';
part 'routes/home_routes.dart';
part 'routes/calendar_routes.dart';
part 'routes/profile_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'RootNavigatorKey');
final _authNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'AuthNavigatorKey');
final _homeRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'HomeRoutesNavigatorKey');
final _calendarRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'CalendarRoutesNavigatorKey');
final _profileRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'ProfileRoutesNavigatorKey');

class AppRouter {
  final String initialLocation;

  AppRouter({required this.initialLocation});

  GoRouter get routerConfig => GoRouter(
        observers: [MyRouteObserver()],
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: kDebugMode,
        initialLocation: initialLocation,
        routes: [
          ..._authRoutes,
          _commonBottomNavigationBarShellRoute,
        ],
        errorBuilder: (_, state) => Placeholder(key: state.pageKey),
      );
}

final _commonBottomNavigationBarShellRoute = StatefulShellRoute.indexedStack(
  branches: [
    _homeRoutesBranch,
    _calendarRoutesBranch,
    _profileRoutesBranch,
  ],
  builder: (_, state, navigationShell) => RootPage(
    key: state.pageKey,
    navigationShell: navigationShell,
  ),
);

final _homeRoutesBranch = StatefulShellBranch(
  observers: [MyRouteObserver()],
  navigatorKey: _homeRoutesNavigatorKey,
  initialLocation: HomeRoutes.home.path,
  routes: [
    ..._homeRoutes,
  ],
);

final _calendarRoutesBranch = StatefulShellBranch(
  observers: [MyRouteObserver()],
  navigatorKey: _calendarRoutesNavigatorKey,
  initialLocation: CalendarRoutes.calendar.path,
  routes: [
    ..._calendarRoutes,
  ],
);

final _profileRoutesBranch = StatefulShellBranch(
  observers: [MyRouteObserver()],
  navigatorKey: _profileRoutesNavigatorKey,
  initialLocation: ProfileRoutes.profile.path,
  routes: [
    ..._profileRoutes,
  ],
);

class MyRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint("Route pushed: ${route.settings.name ?? 'Unknown'} with arguments: ${route.settings.arguments}");
    debugPrint("Previous Route: ${previousRoute?.settings.name ?? 'None'}");
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint("Route popped: ${route.settings.name ?? 'Unknown'}");
    debugPrint("Previous Route: ${previousRoute?.settings.name ?? 'None'}");
    super.didPop(route, previousRoute);
  }
}
