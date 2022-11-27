import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/logger.dart';

abstract class ISecureRepository {
  Future<void> addToStorage(String key, String value);
  Future<String?> getFromStorage(String key);
  Future<Map<String, String>> getAllFromStorage();
  Future<void> deleteFromStorage(String key);
  Future<bool> clearSecureStorage();
  Future<void> clearSecureStorageIfAppReinstalled();
}

class SecureRepository extends ISecureRepository {
  final _flutterSecureStorage = const FlutterSecureStorage();

  /// Can throw a PlatformException.
  @override
  Future<void> addToStorage(String key, String value) async {
    await _flutterSecureStorage.write(key: key, value: value).then((void data) {
      logger.i('$key: $value added to secure storage');
    });
  }

  /// Get value by key
  /// Can throw a PlatformException.
  @override
  Future<String?> getFromStorage(String key) async {
    return _flutterSecureStorage.read(key: key);
  }

  /// Get all values
  /// Can throw a PlatformException.
  @override
  Future<Map<String, String>> getAllFromStorage() async {
    return _flutterSecureStorage.readAll();
  }

  /// Delete value by key
  /// Can throw a PlatformException.
  @override
  Future<void> deleteFromStorage(String key) async {
    await _flutterSecureStorage.delete(key: key).then((void data) {
      logger.i('$key deleted from secure storage');
    });
  }

  /// Delete all values from storage
  /// Can throw a PlatformException.
  @override
  Future<bool> clearSecureStorage() async {
    return _flutterSecureStorage.deleteAll().then((void data) {
      logger.i('Secure storage has been cleared');
      return true;
    });
  }

  @override
  Future<void> clearSecureStorageIfAppReinstalled() async {
    const key = 'first_run';
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getBool(key) ?? true) {
      await clearSecureStorage();
      prefs.setBool(key, false);
    }
  }
}
