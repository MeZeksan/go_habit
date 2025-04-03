import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';

/// Мок-версия карточки привычки без зависимостей BLoC для тестирования
class MockHabitCard extends StatelessWidget {
  final Habit habit;
  final HabitCategory habitCategory;

  const MockHabitCard({
    required this.habit,
    required this.habitCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Color(int.parse(habitCategory.color.replaceAll('#', '0xFF')));
    final isActive = habit.isActive;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  habit.icon ?? '',
                  style: TextStyle(
                    fontSize: 48,
                    color: isActive ? Colors.white : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      habit.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.grey,
                        decoration:
                            isActive ? null : TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      habit.description ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (isActive)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: DateTime.now()
                                .difference(DateTime.parse(
                                    habit.lastCompletedTime ??
                                        '2023-03-31T00:00:00.000'))
                                .inDays ==
                            0
                        ? Colors.grey
                        : cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.check, color: Colors.black),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: isActive
                ? Container(
                    alignment: Alignment.center,
                    child: Text('Статистика привычки: ${habit.title}'),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Привычка неактивна',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(isActive ? 1.0 : 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      getCategoryIcon(habitCategory.id),
                      color: isActive ? Colors.white : Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      habitCategory.name,
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: habit.isActive,
                onChanged: (_) {},
                activeColor: cardColor,
                inactiveThumbColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Вспомогательная функция для получения иконки категории
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

/// Golden тесты для виджета карточки привычки.
///
/// Для генерации новых эталонных снимков используйте:
/// ```
/// flutter test --update-goldens test/widget/habits/habit_card_mock_test.dart
/// ```
///
/// Для запуска тестов с проверкой соответствия существующим снимкам:
/// ```
/// flutter test test/widget/habits/habit_card_mock_test.dart
/// ```
void main() {
  // Инициализируем тестовое окружение
  TestWidgetsFlutterBinding.ensureInitialized();

  // Настраиваем размеры для тестирования на устройствах с разными размерами экранов
  const testSize = Size(400, 300);

  testWidgets('HabitCard renders correctly - active habit', (tester) async {
    // Устанавливаем размер окна
    tester.binding.window.physicalSizeTestValue = testSize;
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    // Создаем тестовые данные
    final habit = Habit(
      id: 'test-habit-1',
      title: 'Читать книгу',
      description: '30 минут чтения каждый день',
      categoryId: 'education',
      icon: '📚',
      lastCompletedTime:
          DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
    );

    final category = HabitCategory(
      id: 'education',
      name: 'Образование',
      color: '#4A90E2',
    );

    // Рендерим виджет в отдельном MaterialApp контексте
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Center(
            child: MockHabitCard(
              habit: habit,
              habitCategory: category,
            ),
          ),
        ),
      ),
    );

    // Проверяем, что основные элементы отображаются корректно
    expect(find.text('Читать книгу'), findsOneWidget);
    expect(find.text('30 минут чтения каждый день'), findsOneWidget);
    expect(find.text('Образование'), findsOneWidget);
    expect(find.text('📚'), findsOneWidget);

    // Сохраняем снимок для визуального сравнения
    await expectLater(
      find.byType(MockHabitCard),
      matchesGoldenFile('golden/habit_card_active.png'),
    );

    // Сбрасываем настройки размера окна
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });

  testWidgets('HabitCard renders correctly - inactive habit', (tester) async {
    // Устанавливаем размер окна
    tester.binding.window.physicalSizeTestValue = testSize;
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    // Создаем тестовые данные для неактивной привычки
    final habit = Habit(
      id: 'test-habit-2',
      title: 'Медитация',
      description: '10 минут медитации',
      categoryId: 'selv-development',
      isActive: false,
      icon: '🧘',
      lastCompletedTime:
          DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
    );

    final category = HabitCategory(
      id: 'selv-development',
      name: 'Саморазвитие',
      color: '#9B59B6',
    );

    // Рендерим виджет
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Center(
            child: MockHabitCard(
              habit: habit,
              habitCategory: category,
            ),
          ),
        ),
      ),
    );

    // Проверяем, что основные элементы отображаются корректно
    expect(find.text('Медитация'), findsOneWidget);
    expect(find.text('10 минут медитации'), findsOneWidget);
    expect(find.text('Саморазвитие'), findsOneWidget);
    expect(find.text('🧘'), findsOneWidget);
    expect(find.text('Привычка неактивна'), findsOneWidget);

    // Сохраняем снимок для визуального сравнения
    await expectLater(
      find.byType(MockHabitCard),
      matchesGoldenFile('golden/habit_card_inactive.png'),
    );

    // Сбрасываем настройки размера окна
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });

  testWidgets('HabitCard renders correctly - habit completed today',
      (tester) async {
    // Устанавливаем размер окна
    tester.binding.window.physicalSizeTestValue = testSize;
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    // Создаем тестовые данные для привычки, выполненной сегодня
    final habit = Habit(
      id: 'test-habit-3',
      title: 'Пробежка',
      description: '5 км каждый день',
      categoryId: 'sport',
      icon: '🏃',
      lastCompletedTime:
          DateTime.now().toIso8601String(), // Привычка выполнена сегодня
    );

    final category = HabitCategory(
      id: 'sport',
      name: 'Спорт',
      color: '#E74C3C',
    );

    // Рендерим виджет
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Center(
            child: MockHabitCard(
              habit: habit,
              habitCategory: category,
            ),
          ),
        ),
      ),
    );

    // Проверяем, что основные элементы отображаются корректно
    expect(find.text('Пробежка'), findsOneWidget);
    expect(find.text('5 км каждый день'), findsOneWidget);
    expect(find.text('Спорт'), findsOneWidget);
    expect(find.text('🏃'), findsOneWidget);
    expect(find.text('Статистика привычки: Пробежка'), findsOneWidget);

    // Сохраняем снимок для визуального сравнения
    await expectLater(
      find.byType(MockHabitCard),
      matchesGoldenFile('golden/habit_card_completed_today.png'),
    );

    // Сбрасываем настройки размера окна
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });
}
