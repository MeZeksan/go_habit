import 'package:flutter/material.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appScopeHolder = AppScopeHolder();

  @override
  void initState() {
    super.initState();
    _appScopeHolder.create();
  }

  @override
  void dispose() {
    _appScopeHolder.drop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeProvider(
      holder: _appScopeHolder,
      // Scope-виджеты поддерживают работу со Scope-интерфейсами.
      child: ScopeBuilder<AppScopeContainer>.withPlaceholder(
        builder: (context, appScope) {
          return MaterialApp.router(
            title: 'YxScopedFlutter Demo',
            routerConfig: appScope.routerConfigDep.get,
          );
        },
        // Этот виджет будет отображаться, пока [appScopeHolder] инициализируется
        placeholder: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
