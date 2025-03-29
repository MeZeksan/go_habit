import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/locale_extension.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.privacy_policy),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.privacy_policy,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Дата последнего обновления: 29 марта 2024",
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            _PolicySection(
              title: "1. Сбор информации",
              content: "Приложение Go Habit собирает следующую информацию:\n"
                  "• Информацию об аккаунте (email)\n"
                  "• Данные о привычках и активности\n"
                  "• Информацию о устройстве (для диагностики)",
            ),
            _PolicySection(
              title: "2. Использование информации",
              content: "Мы используем собранную информацию для:\n"
                  "• Предоставления основных функций приложения\n"
                  "• Улучшения пользовательского опыта\n"
                  "• Отправки уведомлений (только с вашего разрешения)",
            ),
            _PolicySection(
              title: "3. Безопасность данных",
              content:
                  "Мы применяем современные меры безопасности для защиты ваших персональных данных. "
                  "Все данные хранятся в зашифрованном виде и не передаются третьим лицам без вашего согласия.",
            ),
            _PolicySection(
              title: "4. Файлы cookie",
              content:
                  "Наше приложение не использует файлы cookie в традиционном понимании. "
                  "Однако мы сохраняем локальные данные на вашем устройстве для оптимальной работы приложения.",
            ),
            _PolicySection(
              title: "5. Согласие",
              content:
                  "Используя приложение Go Habit, вы соглашаетесь с нашей политикой конфиденциальности. "
                  "Если у вас есть вопросы, свяжитесь с нами по адресу support@gohabit.app",
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                "© 2025 Go Habit. Все права защищены.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const _PolicySection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
