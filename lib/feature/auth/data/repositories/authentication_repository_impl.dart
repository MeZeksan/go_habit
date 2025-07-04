import 'package:go_habit/feature/auth/domain/repositories/i_authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthenticationRepositoryImpl implements IAuthenticationRepository {
  final _supabase = Supabase.instance.client;

  AuthenticationRepositoryImpl();

  @override
  Stream<User?> getCurrentUser() => _supabase.auth.onAuthStateChange.map((data) {
        return data.session?.user;
      });

  @override
  User? getSignedInUser() => _supabase.auth.currentUser;

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
    } on AuthException {
      rethrow;
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Ошибка при создании пользователя');
      }
    } on AuthException {
      rethrow;
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Ошибка выхода из системы: $e');
    }
  }
}
