import 'package:flutter/widgets.dart';

class AuthScope extends StatelessWidget {
  final Widget child;

  const AuthScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider<AuthBloc>(
        // create: (context) => DependenciesScope.of(context).authBloc..add(AuthInitialCheckRequested()),
        // child:
        child;
    // );
  }
}
