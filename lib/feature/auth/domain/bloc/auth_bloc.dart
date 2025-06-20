import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/domain/repositories/i_authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthInitialCheckRequested():
          await _onInitialAuthChecked(event, emit);
        case AuthOnCurrentUserChanged():
          await _onCurrentUserChanged(event, emit);
        case AuthLogoutButtonPressed():
          await _onLogoutButtonPressed(event, emit);
        case AuthErrorOccurred():
          _onAuthErrorOccurred(event, emit);
        case AuthSignInRequested():
          await _onSignInRequested(event, emit);
        case AuthSignUpRequested():
          await _onSignUpRequested(event, emit);
      }
    });

    _startUserSubscription();
  }

  Future<void> _onSignInRequested(AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authenticationRepository.signInWithEmail(email: event.email, password: event.password);
    } on AuthException catch (e) {
      debugPrint(e.toString());
      switch (e.statusCode) {
        case '400' || '401' || '403':
          emit(AuthError('Неправильный логин или пароль'));
        default:
          emit(AuthError('Ошибка авторизации'));
      }
    } catch (e) {
      emit(AuthError('Ошибка сервера'));
    }
  }

  Future<void> _onSignUpRequested(AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authenticationRepository.signUp(email: event.email, password: event.password);
    } on AuthException catch (e) {
      debugPrint(e.toString());
      switch (e.statusCode) {
        case '400' || '401' || '403':
          emit(AuthError(
              'Неккоректные данные, проверьте валидность, пароль должен содержать латинские символы и цифры'));
        default:
          emit(AuthError('Ошибка регистрации'));
      }
    } catch (e) {
      emit(AuthError('Ошибка сервера'));
    }
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
          add(AuthErrorOccurred(error.toString()));
        });

  void _onAuthErrorOccurred(AuthErrorOccurred event, Emitter<AuthState> emit) => emit(AuthError(event.errorMessage));

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
