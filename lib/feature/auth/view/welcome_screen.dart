import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/locale_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//экран заглушка для приветствия пользователя
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'пользователь';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Habit'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout),
        //     onPressed: () {
        //       context.read<app_auth.AuthBloc>().add(
        //             app_auth.AuthSignOutRequested(),
        //           );
        //     },
        //   ),
        // ],
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
                    title: context.l10n.habit_tracking_feature,
                    description: context.l10n.daily_habits_feature),
                const SizedBox(height: 16),
                FeatureCardWidget(
                    context: context,
                    icon: Icons.insert_chart,
                    title: context.l10n.analytics_feature,
                    description: context.l10n.visualization_feature),
                const SizedBox(height: 16),
                FeatureCardWidget(
                    context: context,
                    icon: Icons.notifications_active,
                    title: context.l10n.reminders_feature,
                    description: context.l10n.notifications_feature),
                const SizedBox(height: 16),
                FeatureCardWidget(
                    context: context,
                    icon: Icons.widgets_rounded,
                    title: context.l10n.widgets_feature,
                    description: context.l10n.customWidgets_feature),
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
                    child: Text(context.l10n.start_tracking_button),
                  ),
                ),
              ],
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
