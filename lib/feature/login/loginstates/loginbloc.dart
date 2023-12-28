// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authRepository.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/feature/login/loginstates/loginevent.dart';
import 'package:naraakom/feature/login/loginstates/loginstate.dart';
import 'package:naraakom/feature/login/submission/forgetpasswordstatus.dart';
import 'package:naraakom/feature/login/submission/submissionevent.dart';
import 'package:naraakom/feature/splash/splash.dart';

class loginbloc extends Bloc<loginevent, loginstate> {
  authRepository repo;
  loginbloc(this.repo) : super(loginstate()) {
    on<loginPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phonenumber: event.phoneNumnber)));
    on<loginPasswordrChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    on<loginSubmitted>((event, emit) async {
      emit(state.copyWith(formstatus: formsubmitting()));
      String lang = await Preferences.getlang() ?? 'en';
      try {
        var response = await repo.login(state.phonenumber, state.password);
        if (response['status'] == 'success') {
          User user = repo.getUserFromJson(response['user']);
          await Preferences.saveUserId(response['user']['id']);
          await Preferences.saveUserName(user.name);
          await Preferences.saveAccessToken(response['access_token']);
          await Preferences.saveEmailAddress(user.email);
          await Preferences.savePassword(user.password);
          await Preferences.savePhoneNumber(user.mobile);
          if (response['user']['otp_confirmed'] == 0) {
            emit(state.copyWith(formstatus: requiredValidation(user.mobile)));
          } else {
            emit(state.copyWith(
                formstatus: submissionsuccess(response['message_$lang'])));
          }
        } else {
          emit(state.copyWith(
              formstatus: submissionfailed(response['message_$lang'])));
        }
      } catch (e) {
        emit(state.copyWith(formstatus: submissionfailed(e.toString())));
      }
    });

    on<checkUserExistance>(
      (event, emit) async {
        //check user existance
        var result = await repo.checkUserexistance(event.phoneNumber);
        if (result['status'] == 'success') {
          emit(state.copyWith(forgetPasswordStatus: userexist()));
        } else {
          emit(state.copyWith(
              forgetPasswordStatus:
                  userdoesnotexist(result['message_$defaultLang'])));
        }
      },
    );
  }
}
