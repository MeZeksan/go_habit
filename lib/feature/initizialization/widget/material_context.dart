import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_habit/core/router/app_router.dart';
import 'package:go_habit/feature/auth/widget/auth_scope.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../habits/widget/habits_scope.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      child: HabitsScope(
        child: MaterialApp.router(
          routerConfig: AppRouter().routerConfig,
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
          // builder: (context, child) => AuthScope(child: HabitsScope(child: child!)),
        ),
      ),
    );
  }
}
