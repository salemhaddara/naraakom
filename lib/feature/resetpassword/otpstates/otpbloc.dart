// ignore_for_file: library_prefixes, camel_case_types, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart' as authFirebase;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authRepository.dart';

import 'package:naraakom/feature/resetpassword/otpstates/otpevent.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpstate.dart';
import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';

class otpbloc extends Bloc<otpevent, otpstate> {
  final authRepository repo;
  otpbloc(this.repo) : super(otpstate()) {
    on<otpPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phonenumber: event.phoneNumber)));
    on<otpcodeprovidedChanged>((event, emit) =>
        emit(state.copyWith(codeprovided: event.codeprovided)));
//Function Done and Tested
    on<otpRequested>((event, emit) async {
      otpsubmissionstatus? formstatus;
      int? Token;
      String? verifyId;
      emit(state.copyWith(formstatus: otpformsubmitting()));
      try {
        authFirebase.FirebaseAuth auth = authFirebase.FirebaseAuth.instance;
        await auth.verifyPhoneNumber(
          phoneNumber: state.phonenumber,
          verificationCompleted:
              (authFirebase.PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential).then((value) async {
              if (await repo.saveOtpConfirmation()) {
                formstatus = otpvalidationsuccess('Validation Success');
              }
            });
          },
          verificationFailed: (authFirebase.FirebaseAuthException e) async {
            if (e.code == 'invalid-phone-number') {
              formstatus =
                  otpsendingfailed('The provided phone number is not valid.');
            } else {
              formstatus = otpsendingfailed('The Message Is Not Sended');
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            formstatus = otpsendingsuccess();
            Token = resendToken;
            verifyId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        while (formstatus == null) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
        if (formstatus is otpsendingsuccess) {
          emit(state.copyWith(
              formstatus: otpsendingsuccess(),
              resendtoken: Token,
              verificationId: verifyId));
        } else {
          emit(state.copyWith(formstatus: formstatus));
        }
      } catch (e) {
        emit(state.copyWith(formstatus: otpsendingfailed(e.toString())));
      }
    });
//Function Done and Tested
    on<otpVerifyClicked>((event, emit) async {
      try {
        authFirebase.FirebaseAuth auth = authFirebase.FirebaseAuth.instance;
        emit(state.copyWith(formstatus: otpverifying()));
        authFirebase.PhoneAuthCredential credential =
            authFirebase.PhoneAuthProvider.credential(
                verificationId: state.verificationId,
                smsCode: state.codeprovided);

        await auth.signInWithCredential(credential).then((value) async {
          if (await repo.saveOtpConfirmation()) {
            emit(state.copyWith(
                formstatus: otpvalidationsuccess('Validation Success')));
          } else {
            emit(state.copyWith(
                formstatus: otpvalidationfailed('Please Try Again Later')));
          }
        }).catchError((onError) {
          emit(state.copyWith(
              formstatus: otpvalidationfailed(onError.toString())));
        });
      } catch (e) {
        emit(state.copyWith(formstatus: otpvalidationfailed(e.toString())));
      }
    });

    on<newPassSubmitted>(
      (event, emit) async {
        emit(state.copyWith(formstatus: settingNewPasswordINPROGRESS()));
      },
    );
    on<newPassChanged>(
        (event, emit) => emit(state.copyWith(newPassword: event.newPass)));
  }
}
