// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/User.dart';

class authRepository {
  Future<Map<String, dynamic>> login(String mobile, password) async {
    try {
      final response = await http.post(
        Uri.parse(apiSigninUrl),
        body: json.encode({
          'mobile': mobile,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      return json.decode(response.body);
    } catch (e) {
      return {'status': 'error', 'message': 'Check You Internet Connection'};
    }
  }

  Future<Map<String, dynamic>> signUp(User user) async {
    try {
      final response = await http.post(
        Uri.parse(apiSigupUrl),
        body: json.encode(user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      return json.decode(response.body);
    } catch (e) {
      return {'status': 'error', 'message': 'Check You Internet Connection'};
    }
  }

  Future<String> sendVerificationCode(String phoneNumber) async {
    print('Sending Verification code');
    await Future.delayed(const Duration(seconds: 4));
    print('Sending Successful');
    return '2345';
  }

  Future<User> setNewPass(String pass, String userId) async {
    //THE user id is getten from the otp verification so we can modify the user from it
    print('Setting pass');
    await Future.delayed(const Duration(seconds: 4));
    print('pass setting Successful');
    return User(
        name: 'username',
        user_type: 1,
        email: 'email',
        password: 'password',
        mobile: 'mobile');
  }

  User getUserFromJson(Map<String, dynamic> json) {
    print(json);
    return User(
        email: json['email'],
        password: 'NotReturned',
        name: json['name'],
        user_type: 1,
        mobile: json['mobile']);
  }
}
