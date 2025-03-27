import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class IAppConnect {
  /// Слушает изменение интернет соединения
  Stream<bool> get onConnectChanged;

  /// Проверяет подключение к сети
  ///
  /// Возвращает *true* если доступ в интернет присутствует
  /// иначе *false*
  Future<bool> hasConnect();
}

@immutable
class AppConnect implements IAppConnect {
  @override
  Stream<bool> get onConnectChanged => Connectivity().onConnectivityChanged.map(
        (event) => !event.contains(ConnectivityResult.none),
      );

  const AppConnect();

  @override
  Future<bool> hasConnect() async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}

@immutable
class HasNoConnect implements Exception {
  const HasNoConnect();
}
