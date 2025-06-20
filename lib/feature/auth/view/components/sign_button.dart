import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/extension/locale_extension.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart';

class SignButton extends StatelessWidget {
  const SignButton({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    super.key,
    this.isRegistration = false, // По умолчанию считаем, что это вход
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final bool isRegistration;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is AuthLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    if (isRegistration) {
                      debugPrint('Email: ${_emailController.text}');
                      debugPrint('Password: ${_passwordController.text}');
                      // Для экрана регистрации
                      context.read<AuthBloc>().add(
                            AuthSignUpRequested(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    } else {
                      // Для экрана входа
                      context.read<AuthBloc>().add(
                            AuthSignInRequested(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    }
                  }
                },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: state is AuthLoading
              ? const CircularProgressIndicator()
              : Text(
                  isRegistration ? context.l10n.register : context.l10n.sign_in,
                  style: const TextStyle(fontSize: 16),
                ),
        );
      },
    );
  }
}
