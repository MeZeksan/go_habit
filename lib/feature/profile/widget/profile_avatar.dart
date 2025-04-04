import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/theme_extension.dart';

class ProfileAvatar extends StatelessWidget {
  final String email;

  const ProfileAvatar({
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Маскот tiger
        Stack(
          alignment: Alignment.center,
          children: [
            // Зеленый круг с тенью
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.1),
                border: Border.all(color: Colors.green, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            // Изображение тигра поверх круга
            Image.asset(
              'assets/images/paw.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Email пользователя
        Text(
          email,
          style: context.themeOf.textTheme.headlineSmall,
        ),
      ],
    );
  }
}
