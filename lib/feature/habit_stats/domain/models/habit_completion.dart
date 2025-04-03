import 'package:drift/drift.dart';
import 'package:go_habit/core/database/drift_database.dart';

class HabitCompletionModel {
  final int id;
  final String habitId;
  final DateTime dateComplete;

  HabitCompletionModel({
    required this.id,
    required this.habitId,
    required this.dateComplete,
  });

  factory HabitCompletionModel.fromJson(Map<String, dynamic> json) {
    return HabitCompletionModel(
      id: json['id'] as int,
      habitId: json['habit_id'] as String,
      dateComplete: DateTime.parse(json['date_complete'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habit_id': habitId,
      'date_complete': dateComplete.toIso8601String(),
    };
  }

  HabitCompletionsCompanion toDriftModel() {
    return HabitCompletionsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      dateComplete: Value(dateComplete),
    );
  }

  factory HabitCompletionModel.fromDriftModel(HabitCompletion completion) {
    return HabitCompletionModel(
      id: completion.id,
      habitId: completion.habitId,
      dateComplete: completion.dateComplete,
    );
  }
}
