import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final _supabase = Supabase.instance.client; //ссылка на клиент _supabase

  @override
  Stream<User?> getCurrentUser() {
    return _supabase.auth.onAuthStateChange.map((data) {
      return data.session?.user;
    });
  }

  @override
  User? getSignedInUser() {
    return _supabase.auth.currentUser; // AI assistant
  }

  //авторизация пользователя
  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Пользователь не найден');
      }
    } on AuthException catch (e) {
      throw Exception('Ошибка авторизации: ${e.message}');
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  //регистрация пользователя
  @override
  Future<void> singUp({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Ошибка при создании пользователя');
      }
    } on AuthException catch (e) {
      throw Exception('Ошибка регистрации: ${e.message}');
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  //выход из системы
  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Ошибка выхода из системы: $e');
    }
  }
}
