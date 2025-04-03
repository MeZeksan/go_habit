import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_habit/core/theme/app_theme.dart';
import 'package:go_habit/feature/auth/widget/auth_scope.dart';
import 'package:go_habit/feature/categories/widget/habit_categories_scope.dart';
import 'package:go_habit/feature/habits/widget/habits_scope.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:go_habit/feature/language/domain/bloc/language_bloc.dart';
import 'package:go_habit/l10n/app_localizations.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      child: HabitCategoriesScope(
        child: HabitsScope(
          child: ScopeBuilder<AppScopeContainer>.withPlaceholder(
            // Shows this widget while [appScopeHolder] is loading
            placeholder: const Center(child: CircularProgressIndicator()),
            builder: (context, scope) => BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return MaterialApp.router(
                  routerConfig: scope.routerConfig.get,
                  title: 'Go Habit',
                  theme: AppTheme.defaultTheme.lightTheme,
                  darkTheme: AppTheme.defaultTheme.darkTheme,
                  // themeMode: mmm,
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
                  locale: Locale(state.currentLocale),
                  // builder: (context, child) => AuthScope(child: HabitsScope(child: child!)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
