// language_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/language/data/repository/language_repository_implementation.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepositoryImplementation _repository;
  final String _deviceLocale; // Добавлено: храним deviceLocale

  LanguageBloc(this._repository,
      {required String deviceLocale}) // Изменено: обязательный параметр
      : _deviceLocale = deviceLocale,
        super(LanguageState.initial(deviceLocale)) {
    // Используем deviceLocale для initial
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
    add(LoadLanguage()); // Автоматически запускаем загрузку при создании
  }

  Future<void> _onLoadLanguage(
    LoadLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    final savedLocale = await _repository.getLocale();
    // Используем сохраненную локаль или дефолтную устройственную
    emit(state.copyWith(
      currentLocale: savedLocale ?? _deviceLocale,
    ));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    await _repository.saveLocale(event.locale);
    emit(state.copyWith(currentLocale: event.locale));
  }
}
