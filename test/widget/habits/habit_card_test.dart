import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_habit/feature/categories/domain/models/habit_category.dart';
import 'package:go_habit/feature/habits/data/models/habit.dart';
import 'package:go_habit/feature/habits/view/components/habit_card.dart';
import '../../helpers/golden_test_helper.dart';
import '../../helpers/mock_blocs.dart';
import '../../helpers/date_helper.dart';

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

  // Настройка для тестов
  setUpAll(() async {
    // Настраиваем обработчик канала для emoji
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
        return null;
      },
    );
  });

  testWidgets('HabitCard renders correctly - active habit', (tester) async {
    // Настраиваем размеры для теста
    await setupGoldenTest(tester);

    // Создаем тестовые данные
    final habit = Habit(
      id: 'test-habit-1',
      title: 'Читать книгу',
      description: '30 минут чтения каждый день',
      categoryId: 'education',
      icon: '📚',
      lastCompletedTime: DateHelper.getStableYesterdayIso(),
    );

    final category = HabitCategory(
      id: 'education',
      name: 'Образование',
      color: '#4A90E2',
    );

    // Рендерим виджет с моками блоков и темой
    await tester.pumpWidget(
      MockBlocWrapper(
        child: makeTestableWidget(
          child: HabitCard(
            habit: habit,
            habitCategory: category,
          ),
        ),
      ),
    );

    // Проверяем соответствие golden-снимку
    await expectGoldenMatch(
      tester: tester,
      finder: find.byType(HabitCard),
      goldenPath: 'golden/habit_card_active.png',
    );
  });

  testWidgets('HabitCard renders correctly - inactive habit', (tester) async {
    // Настраиваем размеры для теста
    await setupGoldenTest(tester);

    // Создаем тестовые данные для неактивной привычки
    final habit = Habit(
      id: 'test-habit-2',
      title: 'Медитация',
      description: '10 минут медитации',
      categoryId: 'selv-development',
      isActive: false,
      icon: '🧘',
      lastCompletedTime: DateHelper.getStableTwoDaysAgoIso(),
    );

    final category = HabitCategory(
      id: 'selv-development',
      name: 'Саморазвитие',
      color: '#9B59B6',
    );

    // Рендерим виджет с моками блоков и темой
    await tester.pumpWidget(
      MockBlocWrapper(
        child: makeTestableWidget(
          child: HabitCard(
            habit: habit,
            habitCategory: category,
          ),
        ),
      ),
    );

    // Проверяем соответствие golden-снимку
    await expectGoldenMatch(
      tester: tester,
      finder: find.byType(HabitCard),
      goldenPath: 'golden/habit_card_inactive.png',
    );
  });

  testWidgets('HabitCard renders correctly - habit completed today',
      (tester) async {
    // Настраиваем размеры для теста
    await setupGoldenTest(tester);

    // Создаем тестовые данные для привычки, выполненной сегодня
    final habit = Habit(
      id: 'test-habit-3',
      title: 'Пробежка',
      description: '5 км каждый день',
      categoryId: 'sport',
      icon: '🏃',
      lastCompletedTime: DateHelper.getStableTodayIso(),
    );

    final category = HabitCategory(
      id: 'sport',
      name: 'Спорт',
      color: '#E74C3C',
    );

    // Рендерим виджет с моками блоков и темой
    await tester.pumpWidget(
      MockBlocWrapper(
        child: makeTestableWidget(
          child: HabitCard(
            habit: habit,
            habitCategory: category,
          ),
        ),
      ),
    );

    // Проверяем соответствие golden-снимку
    await expectGoldenMatch(
      tester: tester,
      finder: find.byType(HabitCard),
      goldenPath: 'golden/habit_card_completed_today.png',
    );
  });
}
