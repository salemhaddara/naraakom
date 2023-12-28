// ignore_for_file: file_names, camel_case_types

import '../../../core/utils/Preferences/Preferences.dart';

class personalDetailsRepo {
  Future<Map<String, dynamic>> fetchData() async {
    return {
      'name': await Preferences.getUserName(),
      'phoneNumber': await Preferences.getPhoneNumber(),
      'password': await Preferences.getPassword(),
      'email': await Preferences.getEmailAddress()
    };
  }
  // Future<Map<String,dynamic>>updateDetails(){

  // }
}
