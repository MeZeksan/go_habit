import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/habit_stats/bloc/habit_stats_bloc.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class HabitStatsScope extends StatelessWidget {
  final Widget child;
  const HabitStatsScope({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) => BlocProvider(
        create: (context) => HabitStatsBloc(scope.habitStatsRepository.get)
          ..add(
            HabitsStatsInitialLoad(),
          ),
        child: child,
      ),
    );
  }
}
