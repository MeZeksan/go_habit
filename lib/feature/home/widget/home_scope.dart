import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/home/domain/bloc/home_bloc.dart';
import 'package:go_habit/feature/initizialization/scopes/app_scope_container.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class HomeScope extends StatelessWidget {
  final Widget child;
  const HomeScope({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) => BlocProvider(
        create: (context) => HomeBloc(scope.quoteRepository.get),
        child: child,
      ),
    );
  }
}
