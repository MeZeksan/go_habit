import 'package:go_habit/feature/language/domain/repositories/language_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageRepositoryImplementation implements LanguageRepository {
  static const String localeKey = 'locale';

  @override
  Future<bool> saveLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(localeKey, locale);
  }

  @override
  Future<String?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(localeKey);
  }
}
