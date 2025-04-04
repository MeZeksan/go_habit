import 'package:flutter/material.dart';

enum NotificationType {
  habit,
  achievement,
  reminder,
  system,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final String? habitId;
  final IconData icon;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.icon,
    this.isRead = false,
    this.habitId,
  });

  Color getColor() {
    switch (type) {
      case NotificationType.habit:
        return Colors.blue;
      case NotificationType.achievement:
        return Colors.amber;
      case NotificationType.reminder:
        return Colors.green;
      case NotificationType.system:
        return Colors.grey;
    }
  }
}
