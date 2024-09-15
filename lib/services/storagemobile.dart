// storage_service_mobile.dart

import 'storageservice.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService implements StorageServiceBase {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }
}
