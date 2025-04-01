import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/feature/categories/bloc/habit_category_bloc.dart';
import 'package:go_habit/feature/habits/bloc/habits_bloc.dart';

class HabitCategory {
  final String key;
  final String name;
  final IconData icon;
  final Color color;

  const HabitCategory({required this.key, required this.name, required this.icon, required this.color});
}

const List<HabitCategory> categories = [
  HabitCategory(key: 'health', name: 'Здоровье', icon: Icons.favorite, color: Colors.red),
  HabitCategory(key: 'work', name: 'Работа', icon: Icons.work, color: Colors.blue),
  HabitCategory(key: 'sport', name: 'Спорт', icon: Icons.fitness_center, color: Colors.green),
  HabitCategory(key: 'learning', name: 'Обучение', icon: Icons.school, color: Colors.orange),
  HabitCategory(key: 'hobby', name: 'Хобби', icon: Icons.brush, color: Colors.purple),
  HabitCategory(key: 'social', name: 'Общение', icon: Icons.people, color: Colors.teal),
  HabitCategory(key: 'selfcare', name: 'Саморазвитие', icon: Icons.self_improvement, color: Colors.pink),
];

class AddHabitBottomSheet extends StatefulWidget {
  const AddHabitBottomSheet({super.key});

  @override
  State<AddHabitBottomSheet> createState() => _AddHabitBottomSheetState();
}

class _AddHabitBottomSheetState extends State<AddHabitBottomSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _iconController;
  String _selectedCategory = categories.first.key;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _iconController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _onAddPressed() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final icon = _iconController.text.trim();

    if (title.isNotEmpty && icon.isNotEmpty) {
      context.read<HabitsBloc>().add(
            AddHabit(title: title, description: description, emojiIcon: icon, categoryKey: _selectedCategory),
          );
      Navigator.of(context).pop(); // закрываем модалку
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          MediaQuery.of(context).viewInsets + const EdgeInsets.only(bottom: 40), // чтобы не перекрывалось клавиатурой
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Новая привычка',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Описание привычки',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLength: 1,
              controller: _iconController,
              decoration: const InputDecoration(
                labelText: 'Эмодзи (например, 🧘‍♂️)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Выбор категории
            BlocBuilder<HabitCategoryBloc, HabitCategoryState>(
              builder: (context, state) {
                if (state is HabitCategoryLoaded) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.categories.map((category) {
                      final isSelected = _selectedCategory == category.id;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedCategory = category.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? hexToColor(category.color).withOpacity(0.8) : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(getCategoryIcon(category.id), color: Colors.white),
                              const SizedBox(height: 4),
                              Text(
                                category.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onAddPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Добавить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color hexToColor(String hexString) {
  // Удаляем возможный префикс '#'
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) {
    buffer.write('ff'); // Добавляем непрозрачность (alpha) по умолчанию
  }
  buffer.write(hexString.replaceFirst('#', ''));

  // Преобразуем в целое число и создаем Color
  return Color(int.parse(buffer.toString(), radix: 16));
}

IconData getCategoryIcon(String categoryId) {
  switch (categoryId) {
    case 'art':
      return Icons.brush; // Иконка творчества
    case 'education':
      return Icons.school; // Иконка обучения
    case 'health':
      return Icons.fitness_center; // Иконка здоровья
    case 'money':
      return Icons.attach_money; // Иконка финансов
    case 'selv-development':
      return Icons.self_improvement; // Саморазвитие
    case 'sport':
      return Icons.sports_soccer; // Иконка спорта
    case 'work':
      return Icons.work; // Иконка работы
    default:
      return Icons.category; // Иконка по умолчанию
  }
}
