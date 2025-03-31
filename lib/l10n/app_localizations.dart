import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to Go Habit'**
  String get welcome_back;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get dont_have_account;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create a Go Habit account'**
  String get create_account;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log In'**
  String get already_have_account;

  /// Welcome message with email
  ///
  /// In en, this message translates to:
  /// **'Welcome, {email}!'**
  String welcomeMessage(String email);

  /// No description provided for @app_description_title.
  ///
  /// In en, this message translates to:
  /// **'Go Habit app will help you:'**
  String get app_description_title;

  /// No description provided for @habit_tracking_feature.
  ///
  /// In en, this message translates to:
  /// **'Track your habits and completion streaks!'**
  String get habit_tracking_feature;

  /// No description provided for @daily_habits_feature.
  ///
  /// In en, this message translates to:
  /// **'Create and track daily habits to achieve goals'**
  String get daily_habits_feature;

  /// No description provided for @analytics_feature.
  ///
  /// In en, this message translates to:
  /// **'Progress analysis with charts and cubes!'**
  String get analytics_feature;

  /// No description provided for @visualization_feature.
  ///
  /// In en, this message translates to:
  /// **'Visualize your progress and stay motivated'**
  String get visualization_feature;

  /// No description provided for @reminders_feature.
  ///
  /// In en, this message translates to:
  /// **'Get reminders and motivational phrases!'**
  String get reminders_feature;

  /// No description provided for @notifications_feature.
  ///
  /// In en, this message translates to:
  /// **'Customize notifications to remember your habits'**
  String get notifications_feature;

  /// No description provided for @widgets_feature.
  ///
  /// In en, this message translates to:
  /// **'Habit widgets right on your home screen!'**
  String get widgets_feature;

  /// No description provided for @customWidgets_feature.
  ///
  /// In en, this message translates to:
  /// **'Customize widgets you want to see on home screen'**
  String get customWidgets_feature;

  /// No description provided for @start_tracking_button.
  ///
  /// In en, this message translates to:
  /// **'Start habit tracking'**
  String get start_tracking_button;

  /// No description provided for @password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_label;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get password_required;

  /// No description provided for @password_length.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 6 characters'**
  String get password_length;

  /// No description provided for @confirm_password_label.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password_label;

  /// No description provided for @confirm_password_required.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirm_password_required;

  /// No description provided for @passwords_dont_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwords_dont_match;

  /// No description provided for @email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_label;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get email_required;

  /// No description provided for @email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get email_invalid;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @theme_settings.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get theme_settings;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @widgets.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get widgets;

  /// No description provided for @about_app.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get about_app;

  /// No description provided for @rate_us.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rate_us;

  /// No description provided for @share_app.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get share_app;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @sign_out_confirmation_title.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out_confirmation_title;

  /// No description provided for @sign_out_confirmation_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get sign_out_confirmation_message;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// App version with major, minor and patch numbers
  ///
  /// In en, this message translates to:
  /// **'Version {major}.{minor}.{patch}'**
  String app_version(int major, int minor, int patch);

  /// No description provided for @about_app_description.
  ///
  /// In en, this message translates to:
  /// **'Go Habit is an app designed to help you build and maintain good habits. Track your progress, set reminders, and visualize your journey.'**
  String get about_app_description;

  /// Last update date of the privacy policy
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String privacy_policy_last_updated(String date);

  /// No description provided for @privacy_policy_section1_title.
  ///
  /// In en, this message translates to:
  /// **'1. Information Collection'**
  String get privacy_policy_section1_title;

  /// No description provided for @privacy_policy_section1_content.
  ///
  /// In en, this message translates to:
  /// **'Go Habit app collects the following information:\n• Account information (email)\n• Habit and activity data\n• Device information (for diagnostics)'**
  String get privacy_policy_section1_content;

  /// No description provided for @privacy_policy_section2_title.
  ///
  /// In en, this message translates to:
  /// **'2. Information Usage'**
  String get privacy_policy_section2_title;

  /// No description provided for @privacy_policy_section2_content.
  ///
  /// In en, this message translates to:
  /// **'We use the collected information for:\n• Providing core app functionality\n• Improving user experience\n• Sending notifications (only with your permission)'**
  String get privacy_policy_section2_content;

  /// No description provided for @privacy_policy_section3_title.
  ///
  /// In en, this message translates to:
  /// **'3. Data Security'**
  String get privacy_policy_section3_title;

  /// No description provided for @privacy_policy_section3_content.
  ///
  /// In en, this message translates to:
  /// **'We implement modern security measures to protect your personal data. All data is stored in encrypted form and is not shared with third parties without your consent.'**
  String get privacy_policy_section3_content;

  /// No description provided for @privacy_policy_section4_title.
  ///
  /// In en, this message translates to:
  /// **'4. Cookies'**
  String get privacy_policy_section4_title;

  /// No description provided for @privacy_policy_section4_content.
  ///
  /// In en, this message translates to:
  /// **'Our app does not use cookies in the traditional sense. However, we store local data on your device for optimal app performance.'**
  String get privacy_policy_section4_content;

  /// No description provided for @privacy_policy_section5_title.
  ///
  /// In en, this message translates to:
  /// **'5. Consent'**
  String get privacy_policy_section5_title;

  /// No description provided for @privacy_policy_section5_content.
  ///
  /// In en, this message translates to:
  /// **'By using the Go Habit app, you agree to our privacy policy. If you have any questions, please contact us at support@gohabit.app'**
  String get privacy_policy_section5_content;

  /// Copyright text with year
  ///
  /// In en, this message translates to:
  /// **'© {year} Go Habit. All rights reserved.'**
  String privacy_policy_copyright(String year);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
