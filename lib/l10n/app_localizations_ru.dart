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

  @override
  String get profile_title => 'Профиль';

  @override
  String get theme_settings => 'Темная тема';

  @override
  String get archive => 'Архив';

  @override
  String get notifications => 'Уведомления';

  @override
  String get widgets => 'Виджеты';

  @override
  String get about_app => 'О приложении';

  @override
  String get rate_us => 'Оцените нас';

  @override
  String get share_app => 'Поделиться приложением';

  @override
  String get feedback => 'Обратная связь';

  @override
  String get privacy_policy => 'Политика конфиденциальности';

  @override
  String get sign_out => 'Выйти';

  @override
  String get sign_out_confirmation_title => 'Выход';

  @override
  String get sign_out_confirmation_message => 'Вы уверены, что хотите выйти из аккаунта?';

  @override
  String get cancel => 'Отмена';

  @override
  String get close => 'Закрыть';

  @override
  String app_version(int major, int minor, int patch) {
    return 'Версия $major.$minor.$patch';
  }

  @override
  String get about_app_description => 'Go Habit - это приложение, разработанное для формирования и поддержания полезных привычек. Отслеживайте свой прогресс, устанавливайте напоминания и визуализируйте свой путь.';

  @override
  String privacy_policy_last_updated(String date) {
    return 'Дата последнего обновления: $date';
  }

  @override
  String get privacy_policy_section1_title => '1. Сбор информации';

  @override
  String get privacy_policy_section1_content => 'Приложение Go Habit собирает следующую информацию:\n• Информацию об аккаунте (email)\n• Данные о привычках и активности\n• Информацию о устройстве (для диагностики)';

  @override
  String get privacy_policy_section2_title => '2. Использование информации';

  @override
  String get privacy_policy_section2_content => 'Мы используем собранную информацию для:\n• Предоставления основных функций приложения\n• Улучшения пользовательского опыта\n• Отправки уведомлений (только с вашего разрешения)';

  @override
  String get privacy_policy_section3_title => '3. Безопасность данных';

  @override
  String get privacy_policy_section3_content => 'Мы применяем современные меры безопасности для защиты ваших персональных данных. Все данные хранятся в зашифрованном виде и не передаются третьим лицам без вашего согласия.';

  @override
  String get privacy_policy_section4_title => '4. Файлы cookie';

  @override
  String get privacy_policy_section4_content => 'Наше приложение не использует файлы cookie в традиционном понимании. Однако мы сохраняем локальные данные на вашем устройстве для оптимальной работы приложения.';

  @override
  String get privacy_policy_section5_title => '5. Согласие';

  @override
  String get privacy_policy_section5_content => 'Используя приложение Go Habit, вы соглашаетесь с нашей политикой конфиденциальности. Если у вас есть вопросы, свяжитесь с нами по адресу support@gohabit.app';

  @override
  String privacy_policy_copyright(String year) {
    return '© $year Go Habit. Все права защищены.';
  }
}
