// ignore_for_file: library_prefixes, camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authRepository.dart';

import 'package:naraakom/feature/resetpassword/otpstates/otpevent.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpstate.dart';
import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';

import '../../../core/utils/Models/User.dart';

class otpbloc extends Bloc<otpevent, otpstate> {
  final authRepository repo;
  otpbloc(this.repo) : super(otpstate()) {
    on<otpPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phonenumber: event.phoneNumber)));
    on<otpcodeChanged>((event, emit) => emit(state.copyWith(code: event.code)));
    on<otpcodeprovidedChanged>((event, emit) =>
        emit(state.copyWith(codeprovided: event.codeprovided)));

    on<otpRequested>((event, emit) async {
      emit(state.copyWith(formstatus: otpformsubmitting()));
      try {
        await repo.sendVerificationCode(state.phonenumber,
            onverificationcompleted: (auth, credential) async {
          await auth.signInWithCredential(credential).then((value) {
            emit(state.copyWith(
                formstatus: otpvalidationsuccess('Validation Success')));
          });
        }, onverificationfailed: (auth, message) {
          emit(state.copyWith(formstatus: otpsendingfailed(message)));
        }, oncodeSent: (auth, resendToken, verificationId) {
          emit(state.copyWith(
              formstatus: otpsendingsuccess(),
              resendtoken: resendToken,
              verificationId: verificationId));
        });
      } catch (e) {
        emit(state.copyWith(formstatus: otpsendingfailed(e.toString())));
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
          userId: user.mobile,
        ));
      },
    );
    on<newPassChanged>(
        (event, emit) => emit(state.copyWith(newPassword: event.newPass)));
    on<userIdChanged>(
        (event, emit) => emit(state.copyWith(userId: event.userId)));
  }
}
