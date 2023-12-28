// ignore_for_file: non_constant_identifier_names,file_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
//LANGUAGE SETTINGS
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

//USER ID SETTINGS
  static Future<bool> saveUserId(int userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('userid', userid);
  }

  static Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userid');
  }

  static Future<bool> UsedIdExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userid');
  }

//USER NAME SETTINGS
  static Future<bool> saveUserName(String userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('name', userid);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  static Future<bool> UserNameExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('name');
  }

//ACCESS TOKEN SETTINGS
  static Future<bool> saveAccessToken(String userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('accesstoken', userid);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accesstoken');
  }

  static Future<bool> AccessTokenExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('accesstoken');
  }

  //EMAIL ADDRESS SETTINGS
  static Future<bool> saveEmailAddress(String emailAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('emailAddress', emailAddress);
  }

  static Future<String?> getEmailAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('emailAddress');
  }

  static Future<bool> EmailAddressExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('emailAddress');
  }

  //FULL NAME SETTINGS
  static Future<bool> savePassword(String Password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('Password', Password);
  }

  static Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Password');
  }

  static Future<bool> PasswordExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('Password');
  }

  //PHONE NUMBER SETTINGS
  static Future<bool> savePhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('phonenumber', phoneNumber);
  }

  static Future<String?> getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phonenumber');
  }

  static Future<bool> PhoneNumberExistExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('phonenumber');
  }

//AUTH OPERATION SETTINGS
  static Future<bool> saveAuthOperation(String operation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('authoperation', operation);
  }

  static Future<String?> getAuthOperation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authoperation');
  }
}
