import 'package:flutter/material.dart';

class GreetingTextWidget extends StatelessWidget {
  const GreetingTextWidget({
    super.key,
    required String greetingText,
  }) : _greetingText = greetingText;

  final String _greetingText;

  @override
  Widget build(BuildContext context) {
    return Text(
      _greetingText,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
