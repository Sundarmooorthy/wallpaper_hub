import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const String _isOnBoardingDoneKey = 'isOnBoardingDone';
  static const String _isLoggedInKey = 'isLoggedIn';

  static Future<void> setOnBoardingDone(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isOnBoardingDoneKey, value);
  }

  static Future<bool> isOnBoardingDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isOnBoardingDoneKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }
}
