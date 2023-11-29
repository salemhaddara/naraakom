// ignore_for_file: camel_case_types, body_might_complete_normally_catch_error, library_prefixes

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as authFirebase;
import 'package:http/http.dart' as http;
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';

class authRepository {
  //Function Done and Tested
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
      var result = json.decode(response.body);
      if (result['status'] == 'success') {
        await Preferences.saveUserId(result['user']['id']);
        await Preferences.saveUserName(result['user']['name']);
        await Preferences.saveAccessToken(result['access_token']);
      }
      return result;
    } catch (e) {
      return {'status': 'error', 'message': 'Check You Internet Connection'};
    }
  }

//Function Done and Tested
  Future<bool> saveOtpConfirmation() async {
    final response = await http.post(
      Uri.parse(apiOtpVerifiedUrl),
      body: json.encode({
        'otp_confirmed': true,
        'user_id': '${await Preferences.getUserId()}',
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await Preferences.getAccessToken()}',
      },
    );
    if ((json.decode(response.body))['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

//Function Done and Tested
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

//Function Done and Tested
  Future<void> sendVerificationCode(
    String phoneNumber, {
    required Function(
            authFirebase.FirebaseAuth, authFirebase.PhoneAuthCredential)
        onverificationcompleted,
    required Function(authFirebase.FirebaseAuth, String) onverificationfailed,
    required Function(
            authFirebase.FirebaseAuth, int? resendToken, String verificationId)
        oncodeSent,
  }) async {
    authFirebase.FirebaseAuth auth = authFirebase.FirebaseAuth.instance;
    await authFirebase.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted:
          (authFirebase.PhoneAuthCredential credential) async {
        await onverificationcompleted(auth, credential);
      },
      verificationFailed: (authFirebase.FirebaseAuthException e) async {
        if (e.code == 'invalid-phone-number') {
          await onverificationfailed(
              auth, 'The provided phone number is not valid.');
        }
        await onverificationfailed(
            auth, e.message ?? 'The Message Is Not Sended');
      },
      codeSent: (String verificationId, int? resendToken) async {
        await oncodeSent(auth, resendToken, verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      var response = await http.post(
        Uri.parse(apilogout),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await Preferences.getAccessToken()}',
        },
      );
      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  Future<User> setNewPass(String pass, String userId) async {
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
    return User(
        email: json['email'],
        password: 'NotReturned',
        name: json['name'],
        user_type: 1,
        mobile: json['mobile']);
  }
}
