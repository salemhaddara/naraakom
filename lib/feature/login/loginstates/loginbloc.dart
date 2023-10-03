import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authrepository.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/feature/login/loginstates/loginevent.dart';
import 'package:naraakom/feature/login/loginstates/loginstate.dart';
import 'package:naraakom/feature/login/submission/submissionevent.dart';

class loginbloc extends Bloc<loginevent, loginstate> {
  final authrepository repo;
  loginbloc(this.repo) : super(loginstate()) {
    on<loginPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phonenumber: event.phoneNumnber)));
    on<loginPasswordrChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<loginSubmitted>((event, emit) async {
      emit(state.copyWith(formstatus: formsubmitting()));
      try {
        String userId = await repo.login();
        if (await Preferences.saveUserId(userId)) {
          emit(state.copyWith(formstatus: submissionsuccess()));
        } else {
          emit(state.copyWith(
              formstatus: submissionfailed(Exception('Something went Wrong'))));
        }
      } catch (e) {
        emit(state.copyWith(formstatus: submissionfailed(e as Exception)));
      }
    });
  }
}
