import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/router/routes_enum.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:go_habit/feature/auth/view/welcome_screen.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous is AuthInitial,
        listener: (context, state) {
          if (state is AuthUserAuthenticated) {
            Future.delayed(const Duration(milliseconds: 2500)).whenComplete(() {
              // ignore: use_build_context_synchronously
              context.go(HomeRoutes.home.path);
            });
          }

          if (state is AuthUserUnauthenticated) {
            Future.delayed(const Duration(milliseconds: 2500)).whenComplete(() {
              // ignore: use_build_context_synchronously
              context.go(AuthRoutes.login.path);
            });
          }
        },
        child: const WelcomeScreen());
  }
}
