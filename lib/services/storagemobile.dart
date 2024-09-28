// storage_service_mobile.dart

import 'storageservice.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; 

class StorageService implements StorageServiceBase {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) async {
    if (kIsWeb) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } else {

      await _secureStorage.write(key: key, value: value);
    }
  }

  @override
  Future<String?> read({required String key}) async {
    if (kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } else {
      return await _secureStorage.read(key: key);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    if (kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } else {
      await _secureStorage.delete(key: key);
    }
  }
}