import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_habit/feature/auth/widget/auth_scope.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:go_habit/l10n/app_localizations.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../../habits/widget/habits_scope.dart';

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
          return AuthScope(
            child: HabitsScope(
              child: MaterialApp.router(
                routerConfig: appScope.routerConfigDep.get.routerConfig,
                title: 'Go Habit',
                theme: AppTheme.defaultTheme.lightTheme,
                darkTheme: AppTheme.defaultTheme.darkTheme,
                themeMode: ThemeMode.system,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ru'),
                ],
              ),
            ),
          );
        },
        // Этот виджет будет отображаться, пока [appScopeHolder] инициализируется
        placeholder: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
