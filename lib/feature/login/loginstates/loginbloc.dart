// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authRepository.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/feature/login/loginstates/loginevent.dart';
import 'package:naraakom/feature/login/loginstates/loginstate.dart';
import 'package:naraakom/feature/login/submission/submissionevent.dart';

class loginbloc extends Bloc<loginevent, loginstate> {
  final authRepository repo;
  loginbloc(this.repo) : super(loginstate()) {
    on<loginPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phonenumber: event.phoneNumnber)));
    on<loginPasswordrChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<loginSubmitted>((event, emit) async {
      emit(state.copyWith(formstatus: formsubmitting()));
      try {
        var response = await repo.login(state.phonenumber, state.password);
        print('object');
        if (response['status'] == null) {
          print('fuck');
        }
        if (response['status'] == 'success') {
          User user = repo.getUserFromJson(response['user']);
          await Preferences.saveUserId(response['user']['id']);
          await Preferences.saveUserName(user.name);
          await Preferences.saveAccessToken(response['access_token']);
          emit(state.copyWith(
              formstatus: submissionsuccess(response['message'])));
        } else {
          emit(state.copyWith(
              formstatus: submissionfailed(response['message'])));
        }
      } catch (e) {
        emit(state.copyWith(formstatus: submissionfailed(e.toString())));
      }
    });
  }
}
