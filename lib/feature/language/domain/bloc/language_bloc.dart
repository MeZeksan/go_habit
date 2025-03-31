import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/language/data/repository/language_repository_implementation.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepositoryImplementation _repository;

  LanguageBloc(this._repository) : super(LanguageState.initial()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadLanguage(
    LoadLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    final savedLocale = await _repository.getLocale();
    if (savedLocale != null) {
      emit(state.copyWith(currentLocale: savedLocale));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    await _repository.saveLocale(event.locale);
    emit(state.copyWith(currentLocale: event.locale));
  }
}
