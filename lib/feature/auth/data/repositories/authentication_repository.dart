import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final supabase = Supabase.instance.client; //ссылка на клиент supabase

  @override
  Stream<User?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  getSignedInUser() {
    // TODO: implement getSignedInUser
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmail({required String email}) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
