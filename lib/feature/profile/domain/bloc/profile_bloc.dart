import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc authBloc;

  ProfileBloc({required this.authBloc}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final authState = authBloc.state;
      User? authUser;

      if (authState is AuthUserAuthenticated) {
        authUser = authState.user;
      } else {
        authUser = Supabase.instance.client.auth.currentUser;
      }

      // Если пользователя нет вообще, используем заглушку
      final email = authUser?.email ?? 'Пользователь';

      emit(ProfileLoaded(email: email));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  void _onSignOut(SignOut event, Emitter<ProfileState> emit) {
    authBloc.add(AuthLogoutButtonPressed());
    emit(ProfileSignOutInitiated());
  }
}
