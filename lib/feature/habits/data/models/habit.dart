import 'package:go_habit/core/database/drift_database.dart' as drift;
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'habit.g.dart';

@JsonSerializable()
class Habit {
  final String id;
  final String title;
  final String? description;
  final String? lastCompletedDate;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final bool isActive;
  final int steps;
  final String? icon;

  Habit({
    String? id,
    required this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    required this.categoryId,
    this.isActive = true,
    this.lastCompletedDate,
    this.icon,
    this.steps = 0,
  }) : id = id ?? const Uuid().v4();

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    String? lastCompletedDate,
    int? categoryId,
    String? createdAt,
    String? updatedAt,
    bool? isActive,
    int? steps,
    String? icon,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      steps: steps ?? this.steps,
      icon: icon ?? this.icon,
    );
  }

  factory Habit.fromDriftModel(drift.Habit habit) {
    return Habit(
      id: habit.id,
      title: habit.title,
      description: habit.description,
      lastCompletedDate: habit.lastTimeCompleted.toString(),
      categoryId: habit.categoryId,
      createdAt: habit.createdAt.toString(),
      updatedAt: habit.updatedAt.toString(),
      isActive: habit.isActive,
      steps: habit.steps,
      icon: habit.icon,
    );
  }
}
