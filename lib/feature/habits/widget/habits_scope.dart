import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class HabitsScope extends StatelessWidget {
  final Widget child;

  const HabitsScope({required this.child, super.key});

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
