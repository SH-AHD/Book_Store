import 'dart:convert';

import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;

  static const String kToken = 'token';
  static const String kUser = 'user';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String? token) async {
    if (token == null) return;
    await prefs.setString(kToken, token);
  }

  static String getToken() {
    return prefs.getString(kToken) ?? '';
  }

  static Future<void> saveUsrInfo(User? user) async {
    if (user == null) return;
    var userAsJson=user.toJson();
    var userAsString=jsonEncode(userAsJson);
    await prefs.setString(kUser,userAsString);
  }

  static User? getUsrInfo() {
    var cachedUerInfo=prefs.getString(kUser);
    if(cachedUerInfo==null) return null;
var userInfoAsJson=jsonDecode(cachedUerInfo);
    return User.fromJson(userInfoAsJson);
  }


  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getString(String key) {
    return prefs.getString(key) ?? '';
  }
}
