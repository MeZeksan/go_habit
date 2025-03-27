import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/data/repositories/authentication_repository.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart';

class AuthScope extends StatelessWidget {
  final Widget child;

  const AuthScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        AuthenticationRepository(),
      )..add(AuthCheckRequested()),
      child: child,
    );
  }
}
