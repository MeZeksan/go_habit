// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      categoryId: (json['category_id'] as num).toInt(),
      isActive: json['isActive'] as bool? ?? true,
      lastCompletedDate: json['lastCompletedDate'] as String?,
      icon: json['icon'] as String?,
      steps: (json['steps'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'lastCompletedDate': instance.lastCompletedDate,
      'category_id': instance.categoryId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'isActive': instance.isActive,
      'steps': instance.steps,
      'icon': instance.icon,
    };
