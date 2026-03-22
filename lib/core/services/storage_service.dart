

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static String _isFirstTimeKey = 'isFirstTime';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print("Failed to initialize SharedPreferences: $e");
    }
  }

  static Future<bool> isFirstTimeUser() async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      return prefs.getBool(_isFirstTimeKey) ?? true;
    } catch (e){
      print("Error reading first time user status: $e");
      return true;
    }
  }

  static Future<void> setFirstTimeUser(bool isFirstTime) async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      await prefs.setBool(_isFirstTimeKey, isFirstTime);
    } catch (e){
      print("Error setting first time user statue: $e");
    }
  }
}