import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../initizialization/scopes/app_scope_container.dart';

class HabitsScope extends StatelessWidget {
  final Widget child;

  const HabitsScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(builder: (context, scope) {
      return BlocProvider<HabitsBloc>(
        create: (context) => HabitsBloc(
          scope.habitRepositoryDep.get,
        ),
        child: child,
      );
    });
  }
}
