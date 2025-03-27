import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/auth/domain/bloc/auth_bloc.dart' as app_auth;

class SignButton extends StatelessWidget {
  const SignButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<app_auth.AuthBloc, app_auth.AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is app_auth.AuthLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    context.read<app_auth.AuthBloc>().add(
                          app_auth.AuthSignUpRequested(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  }
                },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: state is app_auth.AuthLoading
              ? const CircularProgressIndicator()
              : const Text(
                  'Зарегистрироваться',
                  style: TextStyle(fontSize: 16),
                ),
        );
      },
    );
  }
}
