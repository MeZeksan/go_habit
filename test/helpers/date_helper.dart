/// Вспомогательные функции для работы с датами в тестах
class DateHelper {
  /// Возвращает стабильную дату для сегодняшнего дня
  /// Это помогает избежать различий в golden тестах при запуске в разные дни
  static DateTime getStableToday() {
    return DateTime(2023, 5, 15); // Используем фиксированную дату
  }

  /// Возвращает стабильную дату для вчерашнего дня
  static DateTime getStableYesterday() {
    return DateTime(2023, 5, 14);
  }

  /// Возвращает стабильную дату для позавчерашнего дня
  static DateTime getStableTwoDaysAgo() {
    return DateTime(2023, 5, 13);
  }

  /// Возвращает стабильную строку ISO8601 для сегодняшнего дня
  static String getStableTodayIso() {
    return getStableToday().toIso8601String();
  }

  /// Возвращает стабильную строку ISO8601 для вчерашнего дня
  static String getStableYesterdayIso() {
    return getStableYesterday().toIso8601String();
  }

  /// Возвращает стабильную строку ISO8601 для позавчерашнего дня
  static String getStableTwoDaysAgoIso() {
    return getStableTwoDaysAgo().toIso8601String();
  }
}
