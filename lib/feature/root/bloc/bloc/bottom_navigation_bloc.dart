import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationInitial()) {
    on<BottomNavigationEvent>((event, emit) {
      switch (event) {
        case BottomNavigationEventChanged():
          emit(BottomNavigationChanged(currentPageIndex: event.pageIndex));
      }
    });
  }
}
