part of 'language_bloc.dart';

abstract class LanguageEvent {}

class LoadLanguage extends LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String locale;

  ChangeLanguage(this.locale);
}
