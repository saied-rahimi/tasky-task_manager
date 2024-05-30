import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class MyPref {
  Future<bool> setToke(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToke() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      'token',
    );
  }

  Future<bool> setRefreshToke(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('refresh_token', value);
  }

  Future<String?> getRefreshToke() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      'refresh_token',
    );
  }
}
