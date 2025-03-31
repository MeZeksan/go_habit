part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUserAuthenticated extends AuthState {
  final User user;

  AuthUserAuthenticated(this.user);
}

class AuthUserUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
