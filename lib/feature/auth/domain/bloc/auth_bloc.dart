import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/data/repositories/authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Bloc для управления аутентификацией
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    // Проверка текущего состояния аутентификации
    on<AuthCheckRequested>((event, emit) async {
      final user = _authRepository.getSignedInUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    // Вход в систему
    on<AuthSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signInWithEmail(
          email: event.email,
          password: event.password,
        );
        final user = _authRepository.getSignedInUser();
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthFailure('Ошибка авторизации'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Регистрация
    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.singUp(
          email: event.email,
          password: event.password,
        );
        final user = _authRepository.getSignedInUser();
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthFailure('Ошибка регистрации'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Выход из системы
    on<AuthSignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signOut();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Подписка на изменения состояния аутентификации
    _authRepository.getCurrentUser().listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }
}
