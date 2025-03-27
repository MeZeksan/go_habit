part of 'auth_bloc.dart';

/// Состояния аутентификации
sealed class AuthState {}

/// Начальное состояние
class AuthInitial extends AuthState {}

/// Состояние загрузки
class AuthLoading extends AuthState {}

/// Состояние успешной аутентификации
class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

/// Состояние отсутствия аутентификации
class AuthUnauthenticated extends AuthState {}

/// Состояние ошибки
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
