import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes_enum.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous is AuthInitial,
      listener: (context, state) {
        if (state is AuthUserAuthenticated) {
          context.go(HomeRoutes.home.path);
        }

        if (state is AuthUserUnauthenticated) {
          context.go(AuthRoutes.login.path);
        }
      },
      child: const Scaffold(
          body: Center(
        child: CircularProgressIndicator.adaptive(),
      )),
    );
  }
}
