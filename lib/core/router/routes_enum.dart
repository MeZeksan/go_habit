const _homeRoutesKey = '/home_routes/';
const _searchRoutesKey = '/search_routes/';
const _addAdRoutesKey = '/add_ad_routes/';
const _adDetailsRoutesKey = '/ad_details_routes/';
const _favouritesRoutesKey = '/favourites_routes/';
const _profileRoutesKey = '/profile_routes/';
const _commonRoutesKey = '/common_routes/';

const _tasksRoutesKey = '/tasks_routes/';
const _nofificationsRoutesKey = '/notifications_routes/';
const _authRoutesKey = '/auth_routes/';

enum AuthRoutes {
  login(path: '${_authRoutesKey}login'),
  authRedirect(path: '${_authRoutesKey}redirect');

  final String path;

  const AuthRoutes({
    required this.path,
  });
}

enum HomeRoutes {
  home(path: '${_homeRoutesKey}home');

  final String path;

  const HomeRoutes({
    required this.path,
  });
}

enum SearchRoutes {
  search(path: '${_searchRoutesKey}search');

  final String path;

  const SearchRoutes({
    required this.path,
  });
}

enum AddAdRoutes {
  ad(path: '${_addAdRoutesKey}ad');

  final String path;

  const AddAdRoutes({
    required this.path,
  });
}

enum FavouritesRoutes {
  favourites(path: '${_favouritesRoutesKey}favourites');

  final String path;

  const FavouritesRoutes({
    required this.path,
  });
}

enum ProfileRoutes {
  profile(path: '${_profileRoutesKey}profile');

  final String path;

  const ProfileRoutes({
    required this.path,
  });
}

enum TasksRoutes {
  tasks(path: '${_tasksRoutesKey}tasks'),
  taskBottomSheet(path: '/task_bottom_sheet');

  final String path;

  const TasksRoutes({
    required this.path,
  });
}

enum NotificationsRoutes {
  notifications(path: '${_nofificationsRoutesKey}notifications');

  final String path;

  const NotificationsRoutes({
    required this.path,
  });
}

enum AdDetailsRoutes {
  details(path: '${_adDetailsRoutesKey}details');

  final String path;

  const AdDetailsRoutes({
    required this.path,
  });
}

enum CommonRoutes {
  confirmDialog(path: '/confirm_dialog');

  final String path;

  const CommonRoutes({
    required this.path,
  });
}
