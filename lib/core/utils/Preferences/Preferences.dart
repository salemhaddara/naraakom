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

  static Future<bool> saveUserId(String userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userid', userid);
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userid');
  }

  // ignore: non_constant_identifier_names
  static Future<bool> UsedIdExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userid');
  }
}
