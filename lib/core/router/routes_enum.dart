const _authRoutesKey = '/auth/';
const _homeRoutesKey = '/home/';
const _calendarRoutesKey = '/calendar/';
const _profileRoutesKey = '/profile/';

enum AuthRoutes {
  login(path: '${_authRoutesKey}login'),
  register(path: '${_authRoutesKey}register'),
  forgotPassword(path: '${_authRoutesKey}forgot-password');

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
