abstract interface class LanguageRepository {
  Future<bool> saveLocale(String locale);

  Future<String?> getLocale();
}
