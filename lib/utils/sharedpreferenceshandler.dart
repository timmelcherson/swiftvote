import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  static Future restore(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return (sharedPrefs.get(key) ?? false);
  }

  static Future<bool> readBool(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.get(key) ?? false;
  }

  static Future<String> readString(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.get(key) ?? false;
  }

  static Future<int> readInt(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.get(key) ?? false;
  }

  static Future<double> readDouble(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.get(key) ?? false;
  }

  static Future<List<String>> readList(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.get(key) ?? false;
  }

  static save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }
}