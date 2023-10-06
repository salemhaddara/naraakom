import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authrepository.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpevent.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpstate.dart';
import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';

import '../../../core/utils/Models/User.dart';

class otpbloc extends Bloc<otpevent, otpstate> {
  final authrepository repo;
  otpbloc(this.repo) : super(otpstate()) {
    on<otpPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phonenumber: event.phoneNumber)));
    on<otpcodeChanged>((event, emit) => emit(state.copyWith(code: event.code)));
    on<otpcodeprovidedChanged>((event, emit) =>
        emit(state.copyWith(codeprovided: event.codeprovided)));

    on<otpSubmitted>((event, emit) async {
      emit(state.copyWith(formstatus: otpformsubmitting()));
      try {
        String code = await repo.sendVerificationCode(state.phonenumber);
        emit(state.copyWith(formstatus: otpsubmissionsuccess(), code: code));
      } catch (e) {
        emit(state.copyWith(formstatus: otpsubmissionfailed(e as Exception)));
      }
    });
    on<otpVerifyClicked>((event, emit) async {
      emit(state.copyWith(formstatus: otpverifying(), isError: false));
      await Future.delayed(const Duration(seconds: 3));
      try {
        if (state.codeprovided == state.code) {
          emit(state.copyWith(
              formstatus: otpverifiyingsuccess(), isError: false));
        } else {
          emit(state.copyWith(
              formstatus: otpverifiyingfailed(Exception('Not Valid')),
              isError: true));
        }
      } catch (e) {
        emit(state.copyWith(formstatus: otpverifiyingfailed(e as Exception)));
      }
    });
    on<newPassSubmitted>(
      (event, emit) async {
        emit(state.copyWith(formstatus: settingNewPasswordINPROGRESS()));
        User user = await repo.setNewPass(state.newPassword, state.UserId);
        emit(state.copyWith(
          formstatus: settingNewPasswordSUCCESS(),
          userId: user.id,
        ));
      },
    );
    on<newPassChanged>(
        (event, emit) => emit(state.copyWith(newPassword: event.newPass)));
    on<userIdChanged>(
        (event, emit) => emit(state.copyWith(userId: event.userId)));
  }
}
