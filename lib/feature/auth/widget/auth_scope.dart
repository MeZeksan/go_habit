import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart' as app_auth;
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../initizialization/scopes/app_scope_container.dart';

class AuthScope extends StatelessWidget {
  final Widget child;

  const AuthScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    //withPlaceholder добавляет проверку на null
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
        builder: (context, scope) {
      return BlocProvider<app_auth.AuthBloc>(
        create: (context) => app_auth.AuthBloc(
          scope.authRepositoryDep.get,
        )..add(app_auth.AuthCheckRequested()),
        child: child,
      );
    });
  }
}
