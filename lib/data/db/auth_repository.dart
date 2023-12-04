import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String stateKey = 'state';
  final String tokenKey = 'user';

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(stateKey) ?? false;
  }

  Future<bool> login() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(stateKey, false);
  }

  Future<bool> saveToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(tokenKey, json.encode(token));
  }

  Future<bool> deleteToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(tokenKey, "");
  }

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    final tokenJson = preferences.getString(tokenKey) ?? "";

    return json.decode(tokenJson);
  }
}
