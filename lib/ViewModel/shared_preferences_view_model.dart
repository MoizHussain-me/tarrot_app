import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> setObject(String key, Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(value);
    return await prefs.setString(key, jsonString);
  }

  static Future<T?> getObject<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)?.isNotEmpty ?? false
        ? _decodeObject<T>(prefs.getString(key)!)
        : null;
  }

  static T _decodeObject<T>(String jsonString) {
    Map<String, dynamic> map = jsonDecode(jsonString);
    return map as T;
  }
}