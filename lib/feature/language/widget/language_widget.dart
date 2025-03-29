import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        // Обработка выбора языка
        print('Selected language: $value');
        // Здесь можно добавить логику смены языка
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Row(
          children: [
            Text('🇷🇺', style: TextStyle(fontSize: 24)),
            Text('RU', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
