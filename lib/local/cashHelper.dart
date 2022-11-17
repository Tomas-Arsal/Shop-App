import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences _sharedPreferences;

  static Future<SharedPreferences> init() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await _sharedPreferences.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return _sharedPreferences.get(key);
  }

  static dynamic saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) await _sharedPreferences.setString(key, value);
    if (value is int) await _sharedPreferences.setInt(key, value);
    if (value is bool)
      await _sharedPreferences.setBool(key, value);
    else
      await _sharedPreferences.setDouble(key, value);
  }
  static Future<bool> removeCacheData({
    required String key,
  }) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clearCacheData({
    required String key,
  }) async {
    return await _sharedPreferences.clear();
  }
}
