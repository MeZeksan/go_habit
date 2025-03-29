import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/bottom_navigation_bloc.dart';

@immutable
class BottomNavigationScope extends StatelessWidget {
  final Widget child;

  const BottomNavigationScope({required this.child, super.key});

  static void change(BuildContext context, int pageIndex) =>
      context.read<BottomNavigationBloc>().add(BottomNavigationEventChanged(pageIndex));

  @override
  Widget build(BuildContext context) => BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(),
        child: child,
      );
}
