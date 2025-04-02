import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:go_habit/feature/categories/domain/models/habit_category.dart';

abstract interface class RemoteHabitCategoryDatasource {
  Future<List<HabitCategory>> getHabitCategories();
}

@reopen
class SupabaseHabitCategoryDataSource extends RemoteHabitCategoryDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseHabitCategoryDataSource(this._supabaseClient);

  @override
  Future<List<HabitCategory>> getHabitCategories() async {
    try {
      final response = await _supabaseClient.from('category').select();
      final categories = response.map(HabitCategory.fromJson).toList();

      return categories;
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch habits: ${e.message}');
    }
  }
}
