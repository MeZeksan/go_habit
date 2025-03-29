import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/extension/locale_extension.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart' as app_auth;
import 'package:go_habit/feature/profile/domain/bloc/profile_bloc.dart';
import 'package:go_habit/feature/profile/widget/profile_avatar.dart';
import 'package:go_habit/feature/profile/widget/settings_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        authBloc: context.read<app_auth.AuthBloc>(),
      )..add(LoadProfile()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final String email =
              state is ProfileLoaded ? state.email : 'Загрузка...';

          return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(context.l10n.profile_title),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileAvatar(email: email),
                    const SizedBox(height: 24),
                    const SettingsSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
