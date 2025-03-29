import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/extension/locale_extension.dart';
import 'package:go_habit/feature/profile/domain/bloc/profile_bloc.dart';
import 'package:go_habit/feature/profile/view/privacy_policy_screen.dart';
import 'package:go_habit/feature/profile/widget/about_app_dialog.dart';
import 'package:go_habit/feature/profile/widget/settings_divider.dart';
import 'package:go_habit/feature/profile/widget/settings_item.dart';
import 'package:go_habit/feature/profile/widget/theme_switch.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Настройка темы
          SettingsItem(
            icon: Icons.dark_mode,
            title: context.l10n.theme_settings,
            trailing: const SizedBox(
              width: 60,
              child: ThemeSwitch(),
            ),
          ),

          const SettingsDivider(),

          // Архив
          SettingsItem(
            icon: Icons.archive_outlined,
            title: context.l10n.archive,
            onTap: () {
              // TODO: Переход на экран архива
            },
          ),

          const SettingsDivider(),

          // Уведомления
          SettingsItem(
            icon: Icons.notifications_outlined,
            title: context.l10n.notifications,
            onTap: () {
              // TODO: Переход на экран уведомлений
            },
          ),

          const SettingsDivider(),

          // Виджеты
          SettingsItem(
            icon: Icons.widgets_outlined,
            title: context.l10n.widgets,
            onTap: () {
              // TODO: Переход на экран виджетов
            },
          ),

          const SettingsDivider(),

          // О приложении
          SettingsItem(
            icon: Icons.info_outline,
            title: context.l10n.about_app,
            onTap: () {
              _showAboutAppDialog(context);
            },
          ),

          const SettingsDivider(),

          // Оцените нас
          SettingsItem(
            icon: Icons.star_border,
            title: context.l10n.rate_us,
            onTap: () {
              // TODO: Реализовать оценку приложения
            },
          ),

          const SettingsDivider(),

          // Поделиться приложением
          SettingsItem(
            icon: Icons.share_outlined,
            title: context.l10n.share_app,
            onTap: () {
              // TODO: Реализовать шаринг приложения
            },
          ),

          const SettingsDivider(),

          // Обратная связь
          SettingsItem(
            icon: Icons.feedback_outlined,
            title: context.l10n.feedback,
            onTap: () {
              // TODO: Реализовать обратную связь
            },
          ),

          const SettingsDivider(),

          // Политика конфиденциальности
          SettingsItem(
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

          const SettingsDivider(),

          // Выход
          SettingsItem(
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

  void _showAboutAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AboutAppDialog(),
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
              context.read<ProfileBloc>().add(SignOut());
            },
            child: Text(context.l10n.sign_out),
          ),
        ],
      ),
    );
  }
}
