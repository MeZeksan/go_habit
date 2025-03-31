part of 'language_bloc.dart';

class LanguageState {
  final String currentLocale;

  const LanguageState({required this.currentLocale});

  // Начальное состояние с локалью по умолчанию
  factory LanguageState.initial() {
    return const LanguageState(currentLocale: 'en');
  }

  // Копирование состояния с новыми параметрами
  LanguageState copyWith({String? currentLocale}) {
    return LanguageState(
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
}
