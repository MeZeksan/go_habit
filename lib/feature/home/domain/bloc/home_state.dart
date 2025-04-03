part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {
  final QuoteModel quote;

  HomeLoading({required this.quote});
}

final class HomeLoadSuccess extends HomeState {
  final QuoteModel quote;

  HomeLoadSuccess({required this.quote});
}

class HomeOperationFailure extends HomeState {
  final String error;

  HomeOperationFailure({required this.error});
}
