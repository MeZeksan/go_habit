part of 'language_bloc.dart';

abstract class LanguageState {
  final String languageCode;

  const LanguageState(this.languageCode);
}

class LanguageInitial extends LanguageState {
  const LanguageInitial()
      : super('en'); // Устанавливаем английский как язык по умолчанию
}

class LanguageChanged extends LanguageState {
  const LanguageChanged(String languageCode) : super(languageCode);
}
