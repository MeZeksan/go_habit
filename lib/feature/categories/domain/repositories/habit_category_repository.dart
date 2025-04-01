import 'package:go_habit/feature/categories/domain/models/habit_category.dart';

abstract interface class HabitCategoryRepository {
  Future<List<HabitCategory>> getHabitCategories();
}
