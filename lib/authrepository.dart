// ignore_for_file: camel_case_types, body_might_complete_normally_catch_error, library_prefixes

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as authFirebase;
import 'package:http/http.dart' as http;
import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/feature/splash/splash.dart';

class authRepository {
  //Function Done and Tested
  Future<Map<String, dynamic>> login(String mobile, password) async {
    try {
      final response = await http.post(
        Uri.parse(apiSigninUrl),
        body: json.encode({
          'mobile': mobile,
          'password': password,
          'user_type': 1,
        }),
        headers: await httpHelper.getHeaderwithOutToken(),
      );
      var result = json.decode(response.body);
      print(result);
      if (result['user_type'] != 1) {
        httpHelper.returnDoctorLoginAttempt();
      }
      if (result['status'] == 'success') {
        saveUserPreferennces(result);
      }
      return result;
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnNetworkError();
    }
  }

//Function Done and Tested
  Future<bool> saveOtpConfirmation() async {
    try {
      final response = await http.post(
        Uri.parse(apiOtpVerifiedUrl),
        body: json.encode({
          'otp_confirmed': true,
          'user_id': Uri.encodeComponent('${await Preferences.getUserId()}'),
        }),
        headers: await httpHelper.getHeaderwithToken(),
      );
      var result = json.decode(response.body);
      if (result['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      return false;
    } catch (e) {
      return false;
    }
  }

//Function Done and Tested
  Future<Map<String, dynamic>> signUp(User user) async {
    try {
      final response = await http.post(
        Uri.parse(apiSigupUrl),
        body: json.encode(user.toJson()),
        headers: await httpHelper.getHeaderwithOutToken(),
      );
      print(json.decode(response.body));
      return json.decode(response.body);
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
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
        headers: await httpHelper.getHeaderwithToken(),
      );

      return json.decode(response.body);
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }

  User getUserFromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        password: 'NotReturned',
        name: json['name'],
        user_type: 1,
        mobile: json['mobile']);
  }

  Future<Map<String, dynamic>> checkUserexistance(String phoneNumber) async {
    try {
      String number = httpHelper.encodeData(phoneNumber);
      var result = await http.get(
          Uri.parse(
            '$apicheckUserExistance?mobile=$number',
          ),
          headers: await httpHelper.getHeaderwithOutToken());
      var response = json.decode(result.body);
      if (response['checked'] == 0) {
        return {'status': 'success', 'message_$defaultLang': 'found'};
      } else {
        return {
          'status': 'error',
          'message_$defaultLang': language[defaultLang]['usernotexist']
        };
      }
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }

  Future<Map<String, dynamic>> updateUserPassword(
      String phoneNumber, String newPass) async {
    String number = httpHelper.encodeData(phoneNumber);
    String pass = httpHelper.encodeData(newPass);
    try {
      var response = await http.get(
          Uri.parse('$apiupdatePassword?mobile=$number&password=$pass'),
          headers: await httpHelper.getHeaderwithOutToken());

      return json.decode(response.body);
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }

  saveUserPreferennces(var result) async {
    await Preferences.saveUserId(result['user']['id']);
    await Preferences.saveUserName(result['user']['name']);
    await Preferences.saveAccessToken(result['access_token']);
  }
}
