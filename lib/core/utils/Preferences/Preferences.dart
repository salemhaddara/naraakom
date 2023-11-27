// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //Localisation Things
  static Future<bool> savelang(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('language', language);
  }

  static Future<String?> getlang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  static Future<bool> langexist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('language');
  }

  static Future<bool> saveUserId(int userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('userid', userid);
  }

  static Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userid');
  }

  // ignore: non_constant_identifier_names
  static Future<bool> UsedIdExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userid');
  }

  static Future<bool> saveUserName(String userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('name', userid);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  // ignore: non_constant_identifier_names
  static Future<bool> UserNameExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('name');
  }

  static Future<bool> saveAccessToken(String userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('accesstoken', userid);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accesstoken');
  }

  // ignore: non_constant_identifier_names
  static Future<bool> AccessTokenExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('accesstoken');
  }
}
