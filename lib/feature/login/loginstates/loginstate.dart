// ignore_for_file: camel_case_types

import 'package:naraakom/feature/login/submission/forgetpasswordstatus.dart';
import 'package:naraakom/feature/login/submission/submissionevent.dart';

class loginstate {
  forgetPasswordStatus forgetpasswordstatus;
  final String phonenumber;
  bool get isValidPhoneNumber {
    return phonenumber.length > 3;
  }

  final String password;
  bool get isValidPassword {
    return password.isNotEmpty && password.length > 8;
  }

  final submissionstatus formstatus;

  loginstate({
    this.phonenumber = '',
    this.password = '',
    this.formstatus = const initialformstatus(),
    this.forgetpasswordstatus = const initialStatusForgetPassword(),
  });

  loginstate copyWith(
      {String? phonenumber,
      String? password,
      submissionstatus? formstatus,
      forgetPasswordStatus? forgetPasswordStatus}) {
    return loginstate(
        phonenumber: phonenumber ?? this.phonenumber,
        password: password ?? this.password,
        formstatus: formstatus ?? this.formstatus,
        forgetpasswordstatus: forgetPasswordStatus ?? forgetpasswordstatus);
  }
}
