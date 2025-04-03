import 'package:go_habit/core/database/drift_database.dart' as drift;
import 'package:json_annotation/json_annotation.dart';

part 'habit_category.g.dart';

@JsonSerializable()
class HabitCategory {
  final String id;
  final String name;
  final String color;

  HabitCategory({required this.id, required this.name, required this.color});

  factory HabitCategory.fromJson(Map<String, dynamic> json) => _$HabitCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$HabitCategoryToJson(this);

  factory HabitCategory.fromDriftModel(drift.HabitCategory category) {
    return HabitCategory(
      id: category.id,
      name: category.name,
      color: category.color,
    );
  }
}
