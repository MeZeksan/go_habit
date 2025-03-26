import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final _supabase = Supabase.instance.client; //ссылка на клиент _supabase

  @override
  Stream<User?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  User? getSignedInUser() {
    return _supabase.auth.currentUser;

    /// AI assistant
  }

  //авторизация пользователя
  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //регистрация пользователя
  @override
  Future<void> singUp({required String email, required String password}) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  //выход из системы
  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
