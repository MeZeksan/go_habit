import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart' as app_auth;
import 'package:go_habit/feature/auth/view/auth_screen.dart';
import 'package:go_habit/feature/auth/widget/auth_scope.dart';
import 'package:go_habit/feature/auth/view/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/environment/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Загрузка переменных окружения
  await dotenv.load(fileName: ".env");

  //supabase init
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      child: MaterialApp(
        title: 'Go Habit',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<app_auth.AuthBloc, app_auth.AuthState>(
          builder: (context, state) {
            if (state is app_auth.AuthLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is app_auth.AuthAuthenticated) {
              // Если пользователь аутентифицирован, перенаправляем на экран приветствия
              return const WelcomeScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
