import 'package:flutter/material.dart';
import 'package:go_habit/core/ui_kit/habit_card_types.dart';

class HabitCardTypeSelector extends StatelessWidget {
  final HabitCardDisplayMode selectedMode;
  final ValueChanged<HabitCardDisplayMode> onModeSelected;

  const HabitCardTypeSelector({
    required this.selectedMode,
    required this.onModeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Выберите тип карточки',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCardTypeOption(context, HabitCardPresets.defaultCard),
              _buildCardTypeOption(context, HabitCardPresets.circularCard),
              _buildCardTypeOption(context, HabitCardPresets.minimalCard),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardTypeOption(BuildContext context, HabitCardConfig config) {
    final isSelected = selectedMode == config.displayMode;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onModeSelected(config.displayMode),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.primaryColor : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              config.icon,
              color: isSelected ? theme.primaryColor : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              config.title,
              style: TextStyle(
                color: isSelected ? theme.primaryColor : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
