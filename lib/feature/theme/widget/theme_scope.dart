import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/theme/theme_cubit.dart';

class ThemeScope extends StatefulWidget {
  final Widget child;

  const ThemeScope({
    required this.child,
    super.key,
  });

  @override
  State<ThemeScope> createState() => _ThemeScopeState();
}

class _ThemeScopeState extends State<ThemeScope> {
  late final ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _themeCubit = ThemeCubit();
  }

  @override
  void dispose() {
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _themeCubit,
      child: widget.child,
    );
  }
}
