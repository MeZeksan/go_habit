import 'package:go_habit/feature/habit_stats/domain/models/habit_completion.dart';
import 'package:go_habit/feature/habit_stats/domain/models/habit_streak.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RemoteHabitStatsDataSource {
  Future<List<HabitCompletionModel>> fetchAllCompletions();
  Future<List<HabitCompletionModel>> fetchCompletions({
    required String habitId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<HabitStreakModel?> fetchStreak(String habitId);
  Future<void> trackCompletion(HabitCompletionModel completion);
  Future<void> updateStreak(HabitStreakModel streak);
  Future<void> syncCompletions(List<HabitCompletionModel> completions);
}

class SupabaseStatsDataSource implements RemoteHabitStatsDataSource {
  final SupabaseClient _supabase;

  SupabaseStatsDataSource(this._supabase);

  @override
  Future<List<HabitCompletionModel>> fetchCompletions({
    required String habitId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = _supabase
          .from('habit_completion')
          .select()
          .eq('habit_id', habitId)
          .eq('user_id', _supabase.auth.currentUser!.id);

      if (startDate != null) {
        query = query.gte('date_complete', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('date_complete', endDate.toIso8601String());
      }

      final response = await query;
      return response.map(HabitCompletionModel.fromJson).toList();
    } on PostgrestException catch (e) {
      throw StatsException('Failed to fetch completions: ${e.message}');
    }
  }

  @override
  Future<HabitStreakModel?> fetchStreak(String habitId) async {
    try {
      final response = await _supabase
          .from('habit_streak')
          .select()
          .eq('habit_id', habitId)
          .eq('user_id', _supabase.auth.currentUser!.id)
          .maybeSingle();

      return response != null ? HabitStreakModel.fromJson(response) : null;
    } on PostgrestException catch (e) {
      throw StatsException('Failed to fetch streak: ${e.message}');
    }
  }

  @override
  Future<void> trackCompletion(HabitCompletionModel completion) async {
    try {
      await _supabase.from('habit_completion').insert({
        'habit_id': completion.habitId,
        'user_id': _supabase.auth.currentUser!.id,
        'date_complete': completion.dateComplete.toIso8601String(),
      });

      // Обновляем last_completed_time в таблице habit
      await _supabase.from('habit').update({
        'last_completed_time': completion.dateComplete.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', completion.habitId);
    } on PostgrestException catch (e) {
      throw StatsException('Failed to track completion: ${e.message}');
    }
  }

  @override
  Future<void> updateStreak(HabitStreakModel streak) async {
    try {
      await _supabase.from('habit_streak').upsert({
        'id': streak.id,
        'habit_id': streak.habitId,
        'user_id': _supabase.auth.currentUser!.id,
        'current_streak': streak.currentStreak,
        'last_update': streak.lastUpdate.toIso8601String(),
      });
    } on PostgrestException catch (e) {
      throw StatsException('Failed to update streak: ${e.message}');
    }
  }

  @override
  Future<void> syncCompletions(List<HabitCompletionModel> completions) async {
    try {
      await _supabase.from('habit_completion').upsert(
            completions.map((c) => c.toJson()).toList(),
            onConflict: 'id',
          );
    } on PostgrestException catch (e) {
      throw StatsException('Failed to sync completions: ${e.message}');
    }
  }

  @override
  Future<List<HabitCompletionModel>> fetchAllCompletions() {
    try {
      return _supabase
          .from('habit_completion')
          .select()
          .eq('user_id', _supabase.auth.currentUser!.id)
          .then((value) => value.map(HabitCompletionModel.fromJson).toList());
    } catch (e) {
      throw StatsException('Failed to fetch completions: $e');
    }
  }
}

class StatsException implements Exception {
  final String message;
  StatsException(this.message);

  @override
  String toString() => 'StatsException: $message';
}
