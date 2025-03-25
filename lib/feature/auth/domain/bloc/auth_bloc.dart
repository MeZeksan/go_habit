import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/i_authentication_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      switch (event) {
        case AuthInitialCheckRequested():
          _onInitialAuthChecked(event, emit);
        case AuthOnCurrentUserChanged():
          _onCurrentUserChanged(event, emit);
        case AuthLogoutButtonPressed():
          _onLogoutButtonPressed(event, emit);
        case AuthErrorOccurred():
          _onAuthErrorOccurred(event, emit);
      }
    });

    _startUserSubscription();
  }

  Future<void> _onInitialAuthChecked(AuthInitialCheckRequested event, Emitter<AuthState> emit) async {
    User? signedInUser = _authenticationRepository.getSignedInUser();
    signedInUser != null ? emit(AuthUserAuthenticated(signedInUser)) : emit(AuthUserUnauthenticated());
  }

  Future<void> _onLogoutButtonPressed(AuthLogoutButtonPressed event, Emitter<AuthState> emit) async {
    await _authenticationRepository.signOut();
  }

  Future<void> _onCurrentUserChanged(AuthOnCurrentUserChanged event, Emitter<AuthState> emit) async =>
      event.user != null ? emit(AuthUserAuthenticated(event.user!)) : emit(AuthUserUnauthenticated());

  void _startUserSubscription() => _userSubscription =
      _authenticationRepository.getCurrentUser().listen((user) => add(AuthOnCurrentUserChanged(user)))
        ..onError((error) {
          add(AuthErrorOccurred(error.toString())); // Обработка ошибок
        });

  void _onAuthErrorOccurred(AuthErrorOccurred event, Emitter<AuthState> emit) => emit(AuthError(event.errorMessage));

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
