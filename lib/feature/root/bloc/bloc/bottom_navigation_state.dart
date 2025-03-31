part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {
  final int currentPageIndex;

  const BottomNavigationState({required this.currentPageIndex});
}

class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial() : super(currentPageIndex: 0);
}

class BottomNavigationChanged extends BottomNavigationState {
  const BottomNavigationChanged({required super.currentPageIndex});
}
