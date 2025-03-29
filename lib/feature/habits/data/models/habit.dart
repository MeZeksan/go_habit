import 'package:go_habit/core/database/drift_database.dart' as drift;
import 'package:go_habit/feature/habits/domain/enums/sync_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'habit.g.dart';

@JsonSerializable()
class Habit {
  final String id;
  final String title;
  final String? description;
  @JsonKey(name: 'last_completed_time')
  final String? lastCompletedTime;
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'is_active')
  final bool isActive;
  final int steps;
  final String? icon;

  @JsonKey(ignore: true)
  final SyncStatus syncStatus;

  Habit({
    String? id,
    required this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    required this.categoryId,
    this.isActive = true,
    this.lastCompletedTime,
    this.icon,
    this.steps = 0,
    this.syncStatus = SyncStatus.synced,
  }) : id = id ?? const Uuid().v4();

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    String? lastCompletedTime,
    String? categoryId,
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
      lastCompletedTime: lastCompletedTime ?? lastCompletedTime,
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
      lastCompletedTime: habit.lastTimeCompleted?.toIso8601String(),
      categoryId: habit.categoryId,
      createdAt: habit.createdAt.toString(),
      updatedAt: habit.updatedAt.toString(),
      isActive: habit.isActive,
      steps: habit.steps,
      icon: habit.icon,
    );
  }
}
