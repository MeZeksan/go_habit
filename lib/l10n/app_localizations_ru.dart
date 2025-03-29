import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcome_back => 'С возвращением в Go Habit';

  @override
  String get dont_have_account => 'Нет аккаунта? Зарегистрироваться';

  @override
  String get registration => 'Регистрация';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get sign_in => 'Войти';

  @override
  String get create_account => 'Создайте аккаунт в Go Habit';

  @override
  String get already_have_account => 'Уже есть аккаунт? Войти';

  @override
  String welcomeMessage(String email) {
    return 'Добро пожаловать, $email!';
  }

  @override
  String get app_description_title => 'Приложение Go Habit поможет вам:';

  @override
  String get habit_tracking_feature => 'Отслеживайте ваши привычки и серию их выполнения!';

  @override
  String get daily_habits_feature => 'Создавайте и отслеживайте ежедневные привычки для достижения целей';

  @override
  String get analytics_feature => 'Анализ прогресса в виде графиков и кубиков!';

  @override
  String get visualization_feature => 'Визуализируйте свой прогресс и получайте мотивацию';

  @override
  String get reminders_feature => 'Получать напоминания и мотивационные фразы!';

  @override
  String get notifications_feature => 'Настраивайте уведомления, чтобы не забывать о своих привычках';

  @override
  String get widgets_feature => 'Виджеты для ваших привычек прямо на главном экране!';

  @override
  String get customWidgets_feature => 'Настраивайте виджеты, которые хотите видеть на главном экране';

  @override
  String get start_tracking_button => 'Начать отслеживание привычек';

  @override
  String get password_label => 'Пароль';

  @override
  String get password_required => 'Пожалуйста, введите пароль';

  @override
  String get password_length => 'Пароль должен содержать минимум 6 символов';

  @override
  String get confirm_password_label => 'Подтвердите пароль';

  @override
  String get confirm_password_required => 'Пожалуйста, подтвердите пароль';

  @override
  String get passwords_dont_match => 'Пароли не совпадают';

  @override
  String get email_label => 'Email';

  @override
  String get email_required => 'Пожалуйста, введите email';

  @override
  String get email_invalid => 'Пожалуйста, введите корректный email';
}
