import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome_back => 'Welcome back to Go Habit';

  @override
  String get dont_have_account => 'Don\'t have an account? Sign Up';

  @override
  String get registration => 'Registration';

  @override
  String get register => 'Register';

  @override
  String get sign_in => 'Sign In';

  @override
  String get create_account => 'Create a Go Habit account';

  @override
  String get already_have_account => 'Already have an account? Log In';

  @override
  String welcomeMessage(String email) {
    return 'Welcome, $email!';
  }

  @override
  String get app_description_title => 'Go Habit app will help you:';

  @override
  String get habit_tracking_feature => 'Track your habits and completion streaks!';

  @override
  String get daily_habits_feature => 'Create and track daily habits to achieve goals';

  @override
  String get analytics_feature => 'Progress analysis with charts and cubes!';

  @override
  String get visualization_feature => 'Visualize your progress and stay motivated';

  @override
  String get reminders_feature => 'Get reminders and motivational phrases!';

  @override
  String get notifications_feature => 'Customize notifications to remember your habits';

  @override
  String get widgets_feature => 'Habit widgets right on your home screen!';

  @override
  String get customWidgets_feature => 'Customize widgets you want to see on home screen';

  @override
  String get start_tracking_button => 'Start habit tracking';

  @override
  String get password_label => 'Password';

  @override
  String get password_required => 'Please enter your password';

  @override
  String get password_length => 'Password must contain at least 6 characters';

  @override
  String get confirm_password_label => 'Confirm password';

  @override
  String get confirm_password_required => 'Please confirm your password';

  @override
  String get passwords_dont_match => 'Passwords don\'t match';

  @override
  String get email_label => 'Email';

  @override
  String get email_required => 'Please enter your email';

  @override
  String get email_invalid => 'Please enter a valid email';
}
