// ignore_for_file: camel_case_types, body_might_complete_normally_catch_error, library_prefixes

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as authFirebase;
import 'package:http/http.dart' as http;
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';

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

  Future<Map<String, dynamic>> saveOtpConfirmation() async {
    final response = await http.post(
      Uri.parse(apiOtpVerifiedUrl),
      body: json.encode({
        'otp_confirmed': true,
        'user_id': await Preferences.getUserId(),
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return {};
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
        onverificationcompleted(auth, credential);
      },
      verificationFailed: (authFirebase.FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          onverificationfailed(auth, 'The provided phone number is not valid.');
        }
        onverificationfailed(auth, e.message ?? 'Unknown Error');
      },
      codeSent: (String verificationId, int? resendToken) async {
        oncodeSent(auth, resendToken, verificationId);
        // authFirebase.PhoneAuthCredential credential = authFirebase.PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
