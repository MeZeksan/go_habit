import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RemoteDataSource {
  Future<List<Habit>> getHabits();
  Future<Habit> getHabitById(String id);
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(String id);
  Stream<List<Habit>> habitsStream();
}

class SupabaseDataSource implements RemoteDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseDataSource(this._supabaseClient);

  // Получить все привычки пользователя
  @override
  Future<List<Habit>> getHabits() async {
    try {
      final response =
          await _supabaseClient.from('habits').select().eq('user_id', _supabaseClient.auth.currentUser!.id);
      final List<Habit> habits = response.map((json) => Habit.fromJson(json)).toList();

      return habits;
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch habits: ${e.message}');
    }
  }

  // Получить привычку по ID
  @override
  Future<Habit> getHabitById(String habitId) async {
    try {
      final response = await _supabaseClient.from('habits').select().eq('id', habitId).single();

      return Habit.fromJson(response);
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch habit: ${e.message}');
    }
  }

  // Добавить новую привычку
  @override
  Future<void> addHabit(Habit habit) async {
    try {
      Map<String, dynamic> habitJson = habit.toJson();
      habitJson['user_id'] = _supabaseClient.auth.currentUser!.id;

      await _supabaseClient.from('habits').insert(habitJson);
    } on PostgrestException catch (e) {
      throw Exception('Failed to add habit: ${e.message}');
    }
  }

  // Обновить существующую привычку
  @override
  Future<void> updateHabit(Habit habit) async {
    try {
      Map<String, dynamic> habitJson = habit.toJson();
      habitJson['updated_at'] = DateTime.now().toIso8601String();

      await _supabaseClient.from('habits').update(habitJson).eq('id', habit.id);
    } on PostgrestException catch (e) {
      throw Exception('Failed to update habit: ${e.message}');
    }
  }

  // Удалить привычку
  @override
  Future<void> deleteHabit(String habitId) async {
    try {
      await _supabaseClient.from('habits').delete().eq('id', habitId);
    } on PostgrestException catch (e) {
      throw Exception('Failed to delete habit: ${e.message}');
    }
  }

  // Подписка на изменения в реальном времени
  @override
  Stream<List<Habit>> habitsStream() {
    return _supabaseClient
        .from('habits')
        .stream(primaryKey: ['id'])
        .eq('user_id', _supabaseClient.auth.currentUser!.id)
        .map((events) => events.map((event) => Habit.fromJson(event)).toList());
  }
}
