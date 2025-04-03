import 'package:go_habit/core/database/drift_database.dart';

class HabitStreakModel {
  final int id;
  final String habitId;
  final int currentStreak;
  final DateTime lastUpdate;

  HabitStreakModel({
    required this.id,
    required this.habitId,
    required this.currentStreak,
    required this.lastUpdate,
  });

  factory HabitStreakModel.fromJson(Map<String, dynamic> json) {
    return HabitStreakModel(
      id: json['id'] as int,
      habitId: json['habit_id'] as String,
      currentStreak: json['current_streak'] as int,
      lastUpdate: DateTime.parse(json['last_update'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habit_id': habitId,
      'current_streak': currentStreak,
      'last_update': lastUpdate.toIso8601String(),
    };
  }

  factory HabitStreakModel.fromDriftModel(HabitStreak streak) {
    return HabitStreakModel(
      id: streak.id,
      habitId: streak.habitId,
      currentStreak: streak.currentStreak,
      lastUpdate: streak.lastUpdate,
    );
  }
}
