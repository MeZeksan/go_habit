import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IAuthenticationRepository {
  Future<void> signInWithEmail({required String email, required String password});
  Future<void> signUp({required String email, required String password});
  Future<void> signOut();
  Stream<User?> getCurrentUser();
  User? getSignedInUser();
}
