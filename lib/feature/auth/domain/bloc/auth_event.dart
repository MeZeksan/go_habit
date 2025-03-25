part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthInitialCheckRequested extends AuthEvent {}

class AuthOnCurrentUserChanged extends AuthEvent {
  final User? user;

  AuthOnCurrentUserChanged(this.user);
}

class AuthLogoutButtonPressed extends AuthEvent {}

class AuthErrorOccurred extends AuthEvent {
  final String errorMessage;

  AuthErrorOccurred(this.errorMessage);
}
