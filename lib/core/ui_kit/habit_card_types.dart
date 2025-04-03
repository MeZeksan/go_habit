import 'package:flutter/material.dart';

/// Типы отображения карточек привычек
enum HabitCardDisplayMode {
  /// Линейный индикатор прогресса
  linear,

  /// Круговой индикатор прогресса вокруг иконки
  circular,

  /// Без индикатора прогресса
  none,
}

/// Конфигурация для разных типов карточек
class HabitCardConfig {
  final HabitCardDisplayMode displayMode;
  final String title;
  final String description;
  final IconData icon;

  const HabitCardConfig({
    required this.displayMode,
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Предустановленные конфигурации карточек
class HabitCardPresets {
  static const HabitCardConfig defaultCard = HabitCardConfig(
    displayMode: HabitCardDisplayMode.linear,
    title: 'Стандартная карточка',
    description: 'Карточка с линейным индикатором прогресса',
    icon: Icons.view_agenda,
  );

  static const HabitCardConfig circularCard = HabitCardConfig(
    displayMode: HabitCardDisplayMode.circular,
    title: 'Круговая карточка',
    description: 'Карточка с круговым индикатором вокруг иконки',
    icon: Icons.radio_button_unchecked,
  );

  static const HabitCardConfig minimalCard = HabitCardConfig(
    displayMode: HabitCardDisplayMode.none,
    title: 'Минимальная карточка',
    description: 'Карточка без индикатора прогресса',
    icon: Icons.view_compact,
  );
}
