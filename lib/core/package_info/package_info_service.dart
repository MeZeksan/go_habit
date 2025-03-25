import 'package:package_info_plus/package_info_plus.dart';

import 'i_package_info_service.dart';

class PackageInfoService implements IPackageInfoService {
  static late final PackageInfo _packageInfo;
  const PackageInfoService();

  @override
  Future<void> init() async => _packageInfo = await PackageInfo.fromPlatform();

  @override
  String get version => _packageInfo.version;
}
