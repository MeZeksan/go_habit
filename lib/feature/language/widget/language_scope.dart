// language_scope.dart
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/language/data/repository/language_repository_implementation.dart';
import 'package:go_habit/feature/language/domain/bloc/language_bloc.dart';

class LanguageScope extends StatefulWidget {
  final Widget child;

  const LanguageScope({super.key, required this.child});

  @override
  State<LanguageScope> createState() => _LanguageScopeState();

  static LanguageBloc of(BuildContext context) => BlocProvider.of<LanguageBloc>(context);
}

class _LanguageScopeState extends State<LanguageScope> {
  late final LanguageBloc _languageBloc;
  late final String _deviceLocale;

  @override
  void initState() {
    super.initState();
    final rawLocale = ui.window.locale.languageCode;
    _deviceLocale = ['en', 'ru'].contains(rawLocale) ? rawLocale : 'en';
    _languageBloc = LanguageBloc(
      LanguageRepositoryImplementation(),
      deviceLocale: _deviceLocale,
    );
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: widget.child,
    );
  }
}
