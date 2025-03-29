part of 'language_bloc.dart';

abstract class LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;

  ChangeLanguage(this.languageCode);
}
