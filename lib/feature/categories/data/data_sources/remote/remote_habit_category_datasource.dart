import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/models/habit_category.dart';

abstract interface class RemoteHabitCategoryDatasource {
  Future<List<HabitCategory>> getHabitCategories();
}

class SupabaseHabitCategoryDataSource extends RemoteHabitCategoryDatasource {
  final SupabaseClient _supabaseClient;

  SupabaseHabitCategoryDataSource(this._supabaseClient);

  @override
  Future<List<HabitCategory>> getHabitCategories() async {
    try {
      final response = await _supabaseClient.from('category').select();
      final List<HabitCategory> categories = response.map((json) => HabitCategory.fromJson(json)).toList();

      return categories;
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch habits: ${e.message}');
    }
  }
}
