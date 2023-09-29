import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<bool> save(String key, String value);

  Future<String?> load(String key);

  Future<bool> remove(String key);
}

class SharedPreferencesImpl extends LocalStorage {
  @override
  Future<String?> load(String key) async =>
      (await SharedPreferences.getInstance()).getString(key);

  @override
  Future<bool> save(String key, String value) async =>
      (await SharedPreferences.getInstance()).setString(key, value);

  @override
  Future<bool> remove(String key) async =>
      (await SharedPreferences.getInstance()).remove(key);
}
