part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested({required this.email, required this.password});
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignUpRequested({required this.email, required this.password});
}

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
