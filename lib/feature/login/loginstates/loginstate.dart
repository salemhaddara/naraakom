// ignore_for_file: camel_case_types

import 'package:naraakom/feature/login/submission/submissionevent.dart';

class loginstate {
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
  });

  loginstate copyWith({
    String? phonenumber,
    String? password,
    submissionstatus? formstatus,
  }) {
    return loginstate(
      phonenumber: phonenumber ?? this.phonenumber,
      password: password ?? this.password,
      formstatus: formstatus ?? this.formstatus,
    );
  }
}
