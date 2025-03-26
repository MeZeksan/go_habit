import 'package:flutter/material.dart';
import 'package:go_habit/feature/auth/domain/repositories/i_authentication_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:yx_scope/yx_scope.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class MockAuthRepository implements IAuthenticationRepository {
  @override
  Stream<User?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  User? getSignedInUser() {
    // TODO: implement getSignedInUser
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmail({required String email}) {
    debugPrint('Sign in with email $email');
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

class AppScopeContainer extends ScopeContainer {
  late final authRepositoryDep = dep<IAuthenticationRepository>(() => MockAuthRepository());

  late final routerConfigDep = dep<RouterConfig<Object>>(() => GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => Scaffold(
                body: Center(
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () => context.go('/home'),
              ),
            )),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => ScopeBuilder<AppScopeContainer>.withPlaceholder(
                builder: (context, appScope) => Scaffold(
                        body: Center(
                      child: ElevatedButton(
                          onPressed: () => appScope.authRepositoryDep.get.signInWithEmail(email: 'fzKl9@example.com'),
                          child: const Text('Home')),
                    )),
                placeholder: Placeholder()),
          ),
        ],
      ));
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}
