import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/extension/locale_extension.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart' as app_auth;
import 'package:go_habit/feature/profile/view/privacy_policy_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Проверка на пользователя до отрисовки экрана
    final authState = context.watch<app_auth.AuthBloc>().state;
    User? authUser;

    if (authState is app_auth.AuthAuthenticated) {
      authUser = authState.user;
    } else {
      authUser = Supabase.instance.client.auth.currentUser;
    }

    // Если пользователя нет вообще, показываем заглушку
    final String email = authUser?.email ?? 'Пользователь';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile_title),
      ),
      body: _ProfileContent(email: email),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final String email;

  const _ProfileContent({required this.email});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Placeholder для маскота
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: Center(
              child: Icon(
                Icons.pets,
                size: 60,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Email пользователя
          Text(
            email,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Настройки
          const _SettingsSection(),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Настройка темы
          _SettingsItem(
            icon: Icons.dark_mode,
            title: context.l10n.theme_settings,
            trailing: const SizedBox(
              width: 60,
              child: _ThemeSwitch(),
            ),
          ),

          _Divider(),

          // Архив
          _SettingsItem(
            icon: Icons.archive_outlined,
            title: context.l10n.archive,
            onTap: () {
              // TODO: Переход на экран архива
            },
          ),

          _Divider(),

          // Уведомления
          _SettingsItem(
            icon: Icons.notifications_outlined,
            title: context.l10n.notifications,
            onTap: () {
              // TODO: Переход на экран уведомлений
            },
          ),

          _Divider(),

          // Виджеты
          _SettingsItem(
            icon: Icons.widgets_outlined,
            title: context.l10n.widgets,
            onTap: () {
              // TODO: Переход на экран виджетов
            },
          ),

          _Divider(),

          // О приложении
          _SettingsItem(
            icon: Icons.info_outline,
            title: context.l10n.about_app,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => _AboutAppDialog(),
              );
            },
          ),

          _Divider(),

          // Оцените нас
          _SettingsItem(
            icon: Icons.star_border,
            title: context.l10n.rate_us,
            onTap: () {
              // TODO: Реализовать оценку приложения
            },
          ),

          _Divider(),

          // Поделиться приложением
          _SettingsItem(
            icon: Icons.share_outlined,
            title: context.l10n.share_app,
            onTap: () {
              // TODO: Реализовать шаринг приложения
            },
          ),

          _Divider(),

          // Обратная связь
          _SettingsItem(
            icon: Icons.feedback_outlined,
            title: context.l10n.feedback,
            onTap: () {
              // TODO: Реализовать обратную связь
            },
          ),

          _Divider(),

          // Политика конфиденциальности
          _SettingsItem(
            icon: Icons.privacy_tip_outlined,
            title: context.l10n.privacy_policy,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),

          _Divider(),

          // Выход
          _SettingsItem(
            icon: Icons.logout,
            title: context.l10n.sign_out,
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              _showSignOutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.sign_out_confirmation_title),
        content: Text(context.l10n.sign_out_confirmation_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<app_auth.AuthBloc>()
                  .add(app_auth.AuthSignOutRequested());
            },
            child: Text(context.l10n.sign_out),
          ),
        ],
      ),
    );
  }
}

class _ThemeSwitch extends StatefulWidget {
  const _ThemeSwitch();

  @override
  State<_ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<_ThemeSwitch> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDarkMode,
      onChanged: (value) {
        setState(() {
          _isDarkMode = value;
          // TODO: Переключить тему
        });
      },
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Colors.green,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 56);
  }
}

class _AboutAppDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.about_app),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Go Habit',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.app_version(1, 0, 0),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.about_app_description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.close),
        ),
      ],
    );
  }
}
