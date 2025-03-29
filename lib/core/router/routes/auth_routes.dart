part of '../app_router.dart';

final _authRoutes = [
  GoRoute(
    parentNavigatorKey: _authNavigatorKey,
    path: AuthRoutes.login.path,
    name: AuthRoutes.login.name,
    builder: (_, state) => LoginPage(key: state.pageKey),
  ),
  GoRoute(
    parentNavigatorKey: _authNavigatorKey,
    path: AuthRoutes.register.path,
    name: AuthRoutes.register.name,
    builder: (_, state) => RegisterPage(key: state.pageKey),
  )
];
