import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authrepository.dart';
import 'package:naraakom/feature/signup/signupstates/signupevent.dart';
import 'package:naraakom/feature/signup/signupstates/signupstate.dart';
import 'package:naraakom/feature/signup/signupsubmission/signupsubmissionevent.dart';

class signupbloc extends Bloc<signupevent, signupstate> {
  final authrepository repo;
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
        await repo.signUp();
        emit(state.copyWith(formstatus: signupsubmissionsuccess()));
      } catch (e) {
        emit(
            state.copyWith(formstatus: signupsubmissionfailed(e as Exception)));
      }
    });
  }
}
