import 'package:yx_scope/yx_scope.dart';

class AppScopeContainer extends ScopeContainer {
  // late final routerDelegateDep = dep(() => AppRouterDelegate());

  // late final appStateObserverDep = dep(() => AppStateObserver(routerDelegateDep.get));
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}
