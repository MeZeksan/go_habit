const _authRoutesKey = '/auth_routes/';
const _homeRoutesKey = '/home_routes/';
const _calendarRoutesKey = '/calendar_routes/';
const _notificationRoutesKey = '/notification_routes/';
const _profileRoutesKey = '/profile_routes/';

enum AuthRoutes {
  login(path: '${_authRoutesKey}login'),
  register(path: '${_authRoutesKey}register'),
  forgotPassword(path: '${_authRoutesKey}forgot-password'),
  welcome(path: '${_authRoutesKey}welcome');

  final String path;

  const AuthRoutes({
    required this.path,
  });
}

enum HomeRoutes {
  home(path: '${_homeRoutesKey}home'),
  tasks(path: '${_homeRoutesKey}tasks');

  final String path;

  const HomeRoutes({
    required this.path,
  });
}

enum CalendarRoutes {
  calendar(path: '${_calendarRoutesKey}calendar');

  final String path;

  const CalendarRoutes({
    required this.path,
  });
}

enum ProfileRoutes {
  profile(path: '${_profileRoutesKey}profile'),
  settings(path: '${_profileRoutesKey}settings');

  final String path;

  const ProfileRoutes({
    required this.path,
  });
}

enum NotificationsRoutes {
  notifications(path: '${_notificationRoutesKey}notifications');

  final String path;

  const NotificationsRoutes({
    required this.path,
  });
}
