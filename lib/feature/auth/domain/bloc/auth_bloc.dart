import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/domain/repositories/i_authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        case AuthSignInRequested():
          _onSignInRequested(event, emit);
      }
    });

    _startUserSubscription();
  }

  Future<void> _onSignInRequested(AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authenticationRepository.signInWithEmail(email: event.email, password: event.password);
  }

  Future<void> _onInitialAuthChecked(AuthInitialCheckRequested event, Emitter<AuthState> emit) async {
    final signedInUser = _authenticationRepository.getSignedInUser();
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
