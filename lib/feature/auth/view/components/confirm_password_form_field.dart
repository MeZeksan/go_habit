import 'package:flutter/material.dart';

class ConfirmPasswordFormField extends StatelessWidget {
  const ConfirmPasswordFormField({
    super.key,
    required TextEditingController controller,
    required TextEditingController passwordController,
    required bool isPasswordVisible,
    required VoidCallback onToggleVisibility,
  })  : _controller = controller,
        _passwordController = passwordController,
        _isPasswordVisible = isPasswordVisible,
        _onToggleVisibility = onToggleVisibility;

  final TextEditingController _controller;
  final TextEditingController _passwordController;
  final bool _isPasswordVisible;
  final VoidCallback _onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Подтвердите пароль',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _onToggleVisibility,
        ),
      ),
      obscureText: !_isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Пожалуйста, подтвердите пароль';
        }
        if (value != _passwordController.text) {
          return 'Пароли не совпадают';
        }
        return null;
      },
    );
  }
}
