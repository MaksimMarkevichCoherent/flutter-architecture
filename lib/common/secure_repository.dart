import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/logger.dart';

class SecureRepository extends FlutterSecureStorage {
  factory SecureRepository() {
    return _instance;
  }

  SecureRepository._privateConstructor();

  static final SecureRepository _instance = SecureRepository._privateConstructor();

  /// Can throw a PlatformException.
  Future<void> addToStorage(String key, String value) async {
    await write(key: key, value: value).then((void data) {
      logger.i('$key: $value added to secure storage');
    });
  }

  /// Get value by key
  /// Can throw a PlatformException.
  Future<String?> getFromStorage(String key) async {
    return read(key: key);
  }

  /// Get all values
  /// Can throw a PlatformException.
  Future<Map<String, String>> getAllFromStorage() async {
    return readAll();
  }

  /// Delete value by key
  /// Can throw a PlatformException.
  Future<void> deleteFromStorage(String key) async {
    await delete(key: key).then((void data) {
      logger.i('$key deleted from secure storage');
    });
  }

  /// Delete all values from storage
  /// Can throw a PlatformException.
  Future<bool> clearSecureStorage() async {
    return deleteAll().then((void data) {
      logger.i('Secure storage has been cleared');
      return true;
    });
  }

  Future<void> clearSecureStorageIfAppReinstalled() async {
    const key = 'first_run';
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getBool(key) ?? true) {
      await clearSecureStorage();
      prefs.setBool(key, false);
    }
  }
}
