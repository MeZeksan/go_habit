abstract interface class IPackageInfoService {
  Future<void> init();
  String get version;
}
