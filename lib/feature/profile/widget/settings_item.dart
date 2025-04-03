import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/theme_extension.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;

  const SettingsItem({
    required this.icon,
    required this.title,
    super.key,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      leading: Icon(
        icon,
        color: iconColor ?? Colors.green,
      ),
      title: Text(
        title,
        style: context.themeOf.textTheme.bodyLarge,
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      tileColor: context.themeOf.cardColor,
    );
  }
}
