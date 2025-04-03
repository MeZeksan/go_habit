import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/ui_kit/habit_card_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class HabitCardSettingsEvent {}

class LoadHabitCardSettings extends HabitCardSettingsEvent {}

class UpdateHabitCardDisplayMode extends HabitCardSettingsEvent {
  final HabitCardDisplayMode mode;
  UpdateHabitCardDisplayMode(this.mode);
}

// States
class HabitCardSettingsState {
  final HabitCardDisplayMode displayMode;

  const HabitCardSettingsState({
    this.displayMode = HabitCardDisplayMode.linear,
  });

  HabitCardSettingsState copyWith({
    HabitCardDisplayMode? displayMode,
  }) {
    return HabitCardSettingsState(
      displayMode: displayMode ?? this.displayMode,
    );
  }
}

// Bloc
class HabitCardSettingsBloc extends Bloc<HabitCardSettingsEvent, HabitCardSettingsState> {
  final SharedPreferences _prefs;
  static const String _displayModeKey = 'habit_card_display_mode';

  HabitCardSettingsBloc(this._prefs) : super(const HabitCardSettingsState()) {
    on<LoadHabitCardSettings>(_onLoadSettings);
    on<UpdateHabitCardDisplayMode>(_onUpdateDisplayMode);
  }

  Future<void> _onLoadSettings(
    LoadHabitCardSettings event,
    Emitter<HabitCardSettingsState> emit,
  ) async {
    final modeIndex = _prefs.getInt(_displayModeKey) ?? 0;
    final mode = HabitCardDisplayMode.values[modeIndex];
    emit(state.copyWith(displayMode: mode));
  }

  Future<void> _onUpdateDisplayMode(
    UpdateHabitCardDisplayMode event,
    Emitter<HabitCardSettingsState> emit,
  ) async {
    await _prefs.setInt(_displayModeKey, event.mode.index);
    emit(state.copyWith(displayMode: event.mode));
  }
}
