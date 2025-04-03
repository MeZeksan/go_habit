/*
part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoadSuccess extends HomeState {}

class HomeOperationFailure extends HomeState {
  final String error;

  HomeOperationFailure({required this.error});
}
*/
