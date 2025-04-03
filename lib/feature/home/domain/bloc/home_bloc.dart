import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/home/domain/models/quote_model.dart';
import 'package:go_habit/feature/home/domain/repositories/quote_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuoteRepository _quoteRepository;

  HomeBloc(this._quoteRepository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      switch (event) {
        case InitializeHome():
          await _onInitialize(event, emit);
        case TigerClicked():
          await _onTigerClicked(event, emit);
      }
    });

    add(InitializeHome());
  }

  Future<void> _onInitialize(InitializeHome event, Emitter<HomeState> emit) async {
    try {
      final quote = await _quoteRepository.getQuote();
      emit(HomeLoadSuccess(quote: quote));
    } catch (error) {
      emit(HomeOperationFailure(error: error.toString()));
    }
  }

  Future<void> _onTigerClicked(TigerClicked event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading(quote: (state as HomeLoadSuccess).quote));
      final quote = await _quoteRepository.getQuote();
      emit(HomeLoadSuccess(quote: quote));
    } catch (error) {}
  }
}
