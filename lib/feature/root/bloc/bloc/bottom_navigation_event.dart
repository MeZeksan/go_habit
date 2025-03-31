part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

class BottomNavigationEventChanged extends BottomNavigationEvent {
  final int pageIndex;
  BottomNavigationEventChanged(this.pageIndex);
}
