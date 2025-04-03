import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/language/domain/bloc/language_bloc.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String flagEmogi = state.currentLocale == 'ru' ? '🇷🇺' : '🇬🇧';
        String languageName = state.currentLocale == 'ru' ? 'РУ' : 'EN';

        return PopupMenuButton<String>(
          offset: const Offset(0, 50), // Позиция выпадающего меню
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'ru',
              child: Row(
                children: [
                  Text('🇷🇺', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('Русский', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'en',
              child: Row(
                children: [
                  Text('🇬🇧', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('English', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            // Добавьте другие языки по необходимости
          ],
          onSelected: (String value) {
            context.read<LanguageBloc>().add(ChangeLanguage(value));
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(flagEmogi, style: const TextStyle(fontSize: 24)),
                Text(languageName, style: const TextStyle(fontSize: 24)),
              ],
            ),
          ),
        );
      },
    );
  }
}
