import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A singleton class that provides secure storage functionality using
/// `flutter_secure_storage` package.
class SecureStorage {
  // Instance of FlutterSecureStorage to handle secure storage operations.
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Singleton instance of SecureStorage.
  static final SecureStorage _secureStorage = SecureStorage._internal();

  /// Factory constructor to return the singleton instance.
  factory SecureStorage() {
    return _secureStorage;
  }

  /// Private named constructor to create the singleton instance.
  SecureStorage._internal();

  /// Returns Android-specific options for secure storage.
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  /// Writes a key-value pair to secure storage.
  ///
  /// [key] The key to identify the value.
  /// [value] The value to be stored.
  Future<void> write({
    required String key,
    required String value,
  }) async {
    await _storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
    );
  }

  /// Reads a value from secure storage for the given key.
  ///
  /// [key] The key to identify the value.
  /// Returns the value associated with the key, or null if the key does not exist.
  Future<String?> read({
    required String key,
  }) async {
    return _storage.read(
      key: key,
      aOptions: _getAndroidOptions(),
    );
  }

  /// Deletes a key-value pair from secure storage.
  ///
  /// [key] The key to identify the value to be deleted.
  Future<void> delete({
    required String key,
  }) async {
    await _storage.delete(
      key: key,
      aOptions: _getAndroidOptions(),
    );
  }
}
