import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart' as app_auth;
import 'package:go_habit/feature/auth/view/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//экран заглушка для приветствия пользователя
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'пользователь';

    return BlocListener<app_auth.AuthBloc, app_auth.AuthState>(
      listener: (context, state) {
        if (state is app_auth.AuthUnauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Go Habit'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<app_auth.AuthBloc>().add(
                      app_auth.AuthSignOutRequested(),
                    );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добро пожаловать, $email!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Приложение Go Habit поможет вам:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  FeatureCardWidget(
                      context: context,
                      icon: Icons.track_changes,
                      title:
                          'Отслеживайте ваши привычки и серию их выполнения!',
                      description:
                          'Создавайте и отслеживайте ежедневные привычки для достижения целей'),
                  const SizedBox(height: 16),
                  FeatureCardWidget(
                      context: context,
                      icon: Icons.insert_chart,
                      title: 'Анализ прогресса в виде графиков и кубиков!',
                      description:
                          'Визуализируйте свой прогресс и получайте мотивацию'),
                  const SizedBox(height: 16),
                  FeatureCardWidget(
                      context: context,
                      icon: Icons.notifications_active,
                      title: 'Получать напоминания и мотивационные фразы!',
                      description:
                          'Настраивайте уведомления, чтобы не забывать о своих привычках'),
                  const SizedBox(height: 16),
                  FeatureCardWidget(
                      context: context,
                      icon: Icons.widgets_rounded,
                      title:
                          'Виджеты для ваших привычек прямо на главном экране!',
                      description:
                          'Настраивайте виджеты, которые хотите видеть на главном экране'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Здесь будет навигация к основному экрану привычек
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Начать отслеживание привычек'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureCardWidget extends StatelessWidget {
  const FeatureCardWidget({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
    required this.description,
  });

  final BuildContext context;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
