// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';
// import 'package:injectable/injectable.dart';
// import '../../feature/ad_details/presentation/ad_details_page.dart';
// import '../../feature/ad_details/presentation/photo_view_page/photo_view_page.dart';
// import '../../feature/add_ad/presentation/add_ad_page.dart';
// import '../../feature/choose_area/presentation/choose_area_page.dart';
// import '../../feature/favourites/presentation/favourites_page.dart';
// import '../../feature/home/presentation/home_page.dart';
// import '../../feature/profile/presentation/profile_page.dart';
// import '../../feature/root/presentation/root_page.dart';
// import '../../feature/search/domain/entity/deal_type.dart';
// import '../../feature/search/domain/entity/real_estate_type.dart';
// import '../../feature/search/domain/entity/rooms.dart';
// import '../../feature/search/domain/entity/search_response.dart';
// import '../../feature/search/presentation/filters/filters_page.dart';
// import '../../feature/search/presentation/search_page.dart';
// import 'routes_enum.dart';

// part 'routes/search_routes.dart';
// part 'routes/add_ad_routes.dart';
// part 'routes/ad_details_routes.dart';
// part 'routes/favourites_routes.dart';
// part 'routes/profile_routes.dart';
// part 'routes/common_routes.dart';

// final _searchRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'SearchRoutesNavigatorKey');
// final _favouritesRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'FavouritesRoutesNavigatorKey');
// final _profileRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'ProfileRoutesNavigatorKey');

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:streaker_app/feature/habits/data/mappers/habit_mapper.dart';
// import 'package:streaker_app/screens/tasks/presentation/habit_and_goals.dart';

// import '../../feature/root/presentation/root_page.dart';
// import '../../screens/auth_redirect/presentation/auth_redirect.dart';
// import '../../screens/home/presentation/home_page.dart';
// import '../../screens/login/presentation/login_page.dart';
// import '../../screens/notifications/notifications_page.dart';
// import '../../screens/profile/profile_page.dart';
// import '../../screens/tasks/presentation/components/task_bottom_sheet.dart';
// import 'routes_enum.dart';

// part 'routes/auth_routes.dart';
// part 'routes/common_routes.dart';
// part 'routes/home_routes.dart';
// part 'routes/notifications_routes.dart';
// part 'routes/profile_routes.dart';
// part 'routes/tasks_routes.dart';

// final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'RootNavigatorKey');
// final _homeRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'HomeRoutesNavigatorKey');
// final _profileRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'ProfileRoutesNavigatorKey');
// final _tasksRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'TasksRoutesNavigatorKey');
// final _nofificationsRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'NotificationsRoutesNavigatorKey');

// class AppRouter {
//   final String initialLocation;

//   AppRouter({required this.initialLocation});

//   GoRouter get routerConfig => GoRouter(
//         observers: [MyRouteObserver()],
//         navigatorKey: rootNavigatorKey,
//         debugLogDiagnostics: kDebugMode,
//         initialLocation: initialLocation,
//         routes: [
//           // ..._addAdRoutes,
//           ..._authRoutes,
//           ..._commonRoutes,
//           _commonBottomNavigationBarShellRoute,
//         ],
//         errorBuilder: (_, state) => Placeholder(key: state.pageKey),
//       );
// }

// final _commonBottomNavigationBarShellRoute = StatefulShellRoute.indexedStack(
//   branches: [
//     _homeRoutesBranch,
//     _tasksRoutesBranch,
//     _nofificationsRoutesBranch,
//     _profileRoutesBranch,
//     // _searchRoutesBranch,
//     // _favouritesRoutesBranch,
//   ],
//   builder: (_, state, navigationShell) => RootPage(
//     key: state.pageKey,
//     navigationShell: navigationShell,
//   ),
// );

// final _homeRoutesBranch = StatefulShellBranch(
//   observers: [MyRouteObserver()],
//   navigatorKey: _homeRoutesNavigatorKey,
//   initialLocation: HomeRoutes.home.path,
//   routes: [
//     ..._homeRoutes,
//     // ..._adDetailsRoutes,
//   ],
// );

// final _profileRoutesBranch = StatefulShellBranch(
//   observers: [MyRouteObserver()],
//   navigatorKey: _profileRoutesNavigatorKey,
//   initialLocation: ProfileRoutes.profile.path,
//   routes: [
//     ..._profileRoutes,
//   ],
// );

// final _tasksRoutesBranch = StatefulShellBranch(
//   observers: [MyRouteObserver()],
//   navigatorKey: _tasksRoutesNavigatorKey,
//   initialLocation: TasksRoutes.tasks.path,
//   routes: [
//     ..._tasksRoutes,
//   ],
// );

// final _nofificationsRoutesBranch = StatefulShellBranch(
//   navigatorKey: _nofificationsRoutesNavigatorKey,
//   initialLocation: NotificationsRoutes.notifications.path,
//   routes: [
//     ..._notificationRoutes,
//   ],
// );

// class MyRouteObserver extends NavigatorObserver {
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     debugPrint("Route pushed: ${route.settings.name ?? 'Unknown'} with arguments: ${route.settings.arguments}");
//     debugPrint("Previous Route: ${previousRoute?.settings.name ?? 'None'}");
//     super.didPush(route, previousRoute);
//   }

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     debugPrint("Route popped: ${route.settings.name ?? 'Unknown'}");
//     debugPrint("Previous Route: ${previousRoute?.settings.name ?? 'None'}");
//     super.didPop(route, previousRoute);
//   }
// }
