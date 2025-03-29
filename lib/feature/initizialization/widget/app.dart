import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_habit/feature/auth/widget/auth_scope.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:go_habit/l10n/app_localizations.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../auth/domain/bloc/auth_bloc.dart' as app_auth;
import '../../auth/view/auth_screen.dart';
import '../../auth/view/welcome_screen.dart';

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
            child: MaterialApp(
              title: 'Go Habit',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
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
              home: BlocBuilder<app_auth.AuthBloc, app_auth.AuthState>(
                builder: (context, state) {
                  if (state is app_auth.AuthLoading) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is app_auth.AuthAuthenticated) {
                    // Если пользователь аутентифицирован, перенаправляем на экран приветствия
                    return const WelcomeScreen();
                  } else {
                    return const AuthScreen();
                  }
                },
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
