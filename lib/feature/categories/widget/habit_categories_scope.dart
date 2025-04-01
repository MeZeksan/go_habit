import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/categories/bloc/habit_category_bloc.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../initizialization/scopes/app_scope_container.dart';

class HabitCategoriesScope extends StatelessWidget {
  final Widget child;
  const HabitCategoriesScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(builder: (context, scope) {
      return BlocProvider<HabitCategoryBloc>(
        lazy: false,
        create: (context) => HabitCategoryBloc(
          scope.habitCategoriesRepositoryDep.get,
        )..add(HabitInitialLoad()),
        child: child,
      );
    });
  }
}
