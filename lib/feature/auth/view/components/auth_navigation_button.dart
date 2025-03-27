import 'package:flutter/material.dart';

/// Универсальная кнопка навигации для экранов аутентификации
class AuthNavigationButton extends StatelessWidget {
  /// Текст кнопки
  final String text;

  /// Функция обратного вызова для обработки навигации
  final VoidCallback onPressed;

  const AuthNavigationButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
