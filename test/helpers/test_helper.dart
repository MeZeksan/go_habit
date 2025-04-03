import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Инициализация golden_toolkit
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Инициализация golden_toolkit
  await loadAppFonts();

  // Запуск тестов
  return testMain();
}
