import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String email;

  const ProfileAvatar({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Placeholder для маскота
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: const Center(
            child: Icon(
              Icons.pets,
              size: 60,
              color: Colors.green,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Email пользователя
        Text(
          email,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
