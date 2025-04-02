import 'package:flutter/material.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:go_habit/feature/initizialization/widget/material_context.dart';
import 'package:go_habit/feature/language/widget/language_scope.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppScopeHolder _appScopeHolder;

  @override
  void initState() {
    super.initState();
    _appScopeHolder = AppScopeHolder();
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
      child: const LanguageScope(child: MaterialContext()),
    );
  }
}

Future<void> loadError() => Future.error(Exception('Ooo'));
