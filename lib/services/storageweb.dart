// storage_service_web.dart

import 'storageservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService implements StorageServiceBase {
  @override
  Future<void> write({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> read({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> delete({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
