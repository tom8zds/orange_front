import 'package:hive_flutter/hive_flutter.dart';

const String serverKey = "server";

class SettingRepo {
  final Box _box;

  static SettingRepo? _instance;

  static SettingRepo get instance => _instance!;

  SettingRepo(this._box) {
    _instance = this;
  }

  String? getServer() {
    var server = _box.get(serverKey);
    if (server is String) {
      return server;
    }
    return null;
  }

  void setServer(String server) {
    _box.put(serverKey, server);
  }
}
