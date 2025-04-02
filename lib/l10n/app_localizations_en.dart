// ignore: unused_import
import 'package:intl/intl.dart' as intl;
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

  @override
  String get profile_title => 'Profile';

  @override
  String get theme_settings => 'Dark theme';

  @override
  String get archive => 'Archive';

  @override
  String get notifications => 'Notifications';

  @override
  String get widgets => 'Widgets';

  @override
  String get about_app => 'About App';

  @override
  String get rate_us => 'Rate Us';

  @override
  String get share_app => 'Share App';

  @override
  String get feedback => 'Feedback';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get sign_out => 'Sign Out';

  @override
  String get sign_out_confirmation_title => 'Sign Out';

  @override
  String get sign_out_confirmation_message => 'Are you sure you want to sign out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String app_version(int major, int minor, int patch) {
    return 'Version $major.$minor.$patch';
  }

  @override
  String get about_app_description => 'Go Habit is an app designed to help you build and maintain good habits. Track your progress, set reminders, and visualize your journey.';

  @override
  String privacy_policy_last_updated(String date) {
    return 'Last updated: $date';
  }

  @override
  String get privacy_policy_section1_title => '1. Information Collection';

  @override
  String get privacy_policy_section1_content => 'Go Habit app collects the following information:\n• Account information (email)\n• Habit and activity data\n• Device information (for diagnostics)';

  @override
  String get privacy_policy_section2_title => '2. Information Usage';

  @override
  String get privacy_policy_section2_content => 'We use the collected information for:\n• Providing core app functionality\n• Improving user experience\n• Sending notifications (only with your permission)';

  @override
  String get privacy_policy_section3_title => '3. Data Security';

  @override
  String get privacy_policy_section3_content => 'We implement modern security measures to protect your personal data. All data is stored in encrypted form and is not shared with third parties without your consent.';

  @override
  String get privacy_policy_section4_title => '4. Cookies';

  @override
  String get privacy_policy_section4_content => 'Our app does not use cookies in the traditional sense. However, we store local data on your device for optimal app performance.';

  @override
  String get privacy_policy_section5_title => '5. Consent';

  @override
  String get privacy_policy_section5_content => 'By using the Go Habit app, you agree to our privacy policy. If you have any questions, please contact us at support@gohabit.app';

  @override
  String privacy_policy_copyright(String year) {
    return '© $year Go Habit. All rights reserved.';
  }
}
