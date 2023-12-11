// ignore_for_file: file_names,camel_case_types

import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/feature/splash/splash.dart';

class httpHelper {
  static getHeaderwithToken() async {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Preferences.getAccessToken()}'
    };
  }

  static getHeaderwithOutToken() {
    return {
      'Content-Type': 'application/json',
    };
  }

  static encodeData(String data) {
    return Uri.encodeComponent(data);
  }

  static Future<Map<String, dynamic>> returnNetworkError() async {
    return {
      'status': 'error',
      'message_${await Preferences.getlang()}': language[defaultLang]
          ['networkError']
    };
  }

  static Future<Map<String, dynamic>> returnServerError() async {
    return {
      'status': 'error',
      'message_${await Preferences.getlang()}': language[defaultLang]
          ['serverError']
    };
  }

  static returnDoctorLoginAttempt() async {
    return {
      'status': 'error',
      'message_${await Preferences.getlang()}': language[defaultLang]
          ['doctorLoginAttempt']
    };
  }
}
