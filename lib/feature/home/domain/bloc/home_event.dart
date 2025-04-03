part of 'home_bloc.dart';

sealed class HomeEvent {}

final class InitializeHome extends HomeEvent {}

final class TigerClicked extends HomeEvent {}
