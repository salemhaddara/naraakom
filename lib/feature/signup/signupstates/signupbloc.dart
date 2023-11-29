// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authRepository.dart';
import 'package:naraakom/feature/signup/signupstates/signupevent.dart';
import 'package:naraakom/feature/signup/signupstates/signupstate.dart';
import 'package:naraakom/feature/signup/signupsubmission/signupsubmissionevent.dart';

class signupbloc extends Bloc<signupevent, signupstate> {
  final authRepository repo;
  signupbloc(this.repo) : super(signupstate()) {
    on<signupPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phonenumber: event.phoneNumnber)));
    on<signupPasswordrChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<signupEmailChanged>(
        (event, emit) => emit(state.copyWith(password: event.email)));
    on<signupNameChanged>(
        (event, emit) => emit(state.copyWith(password: event.name)));
    on<signupSubmitted>((event, emit) async {
      emit(state.copyWith(formstatus: signupformsubmitting()));
      try {
        //Sign Up User
        var response = await repo.signUp(event.user);
        if (response['status'] == 'success') {
          //SIGN IN THE USER FOR GETTING ID REQUIRED FOR OTP
          var response2 =
              await repo.login(event.user.mobile, event.user.password);

          //HANDLING ERROR AND SUCCESS
          if (response2['status'] == 'success') {
            emit(state.copyWith(formstatus: requiredverification()));
          } else {
            emit(state.copyWith(
                formstatus: signupsubmissionfailed(response['message'])));
          }
        } else {
          emit(state.copyWith(
              formstatus: signupsubmissionfailed(response['message'])));
        }
      } catch (e) {
        emit(state.copyWith(formstatus: signupsubmissionfailed(e.toString())));
      }
    });
  }
}
