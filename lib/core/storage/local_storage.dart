import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  Future<String?> getString(String key);
  Future<bool> setString(String key, String value);

  Future<bool?> getBool(String key);
  Future<bool> setBool(String key, bool value);

  Future<bool> remove(String key);
  Future<bool> clear();
  Future<bool> containsKey(String key);
}

class SharedPreferencesLocalStorage implements ILocalStorage {
  final SharedPreferences _prefs;

  SharedPreferencesLocalStorage(this._prefs);

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  @override
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  @override
  Future<bool> clear() async {
    return await _prefs.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }
}
