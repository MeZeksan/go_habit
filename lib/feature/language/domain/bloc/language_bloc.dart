import 'package:flutter_bloc/flutter_bloc.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial());

  @override
  LanguageState get initialState => LanguageInitial();
}
