import 'package:flutter/material.dart';
import 'package:go_habit/l10n/app_localizations.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required TextEditingController controller,
    required bool isPasswordVisible,
    required VoidCallback onToggleVisibility,
  })  : _controller = controller,
        _isPasswordVisible = isPasswordVisible,
        _onToggleVisibility = onToggleVisibility;

  final TextEditingController _controller;
  final bool _isPasswordVisible;
  final VoidCallback _onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: localizations.password_label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
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
          return localizations.password_required;
        }
        if (value.length < 6) {
          return localizations.password_length;
        }
        return null;
      },
    );
  }
}
