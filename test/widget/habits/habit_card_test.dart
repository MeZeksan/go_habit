import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:go_habit/feature/habits/view/components/habit_card.dart';

/// Golden тесты для виджета HabitCard.
///
/// Для генерации новых эталонных снимков используйте:
/// ```
/// flutter test --update-goldens test/widget/habits/habit_card_test.dart
/// ```
///
/// Для запуска тестов с проверкой соответствия существующим снимкам:
/// ```
/// flutter test test/widget/habits/habit_card_test.dart
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

    // Рендерим виджет в отдельном MaterialApp контексте без Bloc-зависимостей
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Center(
            child: HabitCard(
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
      find.byType(HabitCard),
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
            child: HabitCard(
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
      find.byType(HabitCard),
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
            child: HabitCard(
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

    // Сохраняем снимок для визуального сравнения
    await expectLater(
      find.byType(HabitCard),
      matchesGoldenFile('golden/habit_card_completed_today.png'),
    );

    // Сбрасываем настройки размера окна
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });
}
