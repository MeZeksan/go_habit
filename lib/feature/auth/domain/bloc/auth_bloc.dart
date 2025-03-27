import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/data/repositories/authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthCheckRequested>(_onCheckRequested);
  }
  void _onSignInRequested(AuthSignInRequested event, Emitter<AuthState> emit) {
    emit(AuthLoading());
  }

  void _onSignUpRequested(AuthSignUpRequested event, Emitter<AuthState> emit) {
    emit(AuthLoading());
  }

  void _onSignOutRequested(
      AuthSignOutRequested event, Emitter<AuthState> emit) {
    emit(AuthLoading());
  }

  void _onCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) {
    emit(AuthLoading());
  }
}
