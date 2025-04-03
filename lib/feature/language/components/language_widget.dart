import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/extension/theme_extension.dart';
import 'package:go_habit/feature/language/domain/bloc/language_bloc.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final flagEmogi = state.currentLocale == 'ru' ? '🇷🇺' : '🇬🇧';
        final languageName = state.currentLocale == 'ru' ? 'РУ' : 'EN';

        return PopupMenuButton<String>(
          offset: const Offset(0, 50), // Позиция выпадающего меню
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'ru',
              child: Row(
                children: [
                  const Text('🇷🇺', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text('Русский', style: context.themeOf.textTheme.bodyLarge),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'en',
              child: Row(
                children: [
                  const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text('English', style: context.themeOf.textTheme.bodyLarge),
                ],
              ),
            ),
            // Добавьте другие языки по необходимости
          ],
          onSelected: (value) {
            context.read<LanguageBloc>().add(ChangeLanguage(value));
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(flagEmogi, style: const TextStyle(fontSize: 24)),
                Text(languageName, style: context.themeOf.textTheme.bodyLarge),
              ],
            ),
          ),
        );
      },
    );
  }
}
