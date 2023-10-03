import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';

class otpstate {
  final String phonenumber;

  final String code;
  final String codeprovided;
  final bool isError;
  final otpsubmissionstatus formstatus;

  otpstate({
    this.phonenumber = '',
    this.code = '',
    this.codeprovided = '',
    this.isError = false,
    this.formstatus = const initialotpformstatus(),
  });

  otpstate copyWith({
    String? phonenumber,
    String? code,
    String? codeprovided,
    bool? isError,
    otpsubmissionstatus? formstatus,
  }) {
    return otpstate(
      phonenumber: phonenumber ?? this.phonenumber,
      code: code ?? this.code,
      codeprovided: codeprovided ?? this.codeprovided,
      isError: isError ?? this.isError,
      formstatus: formstatus ?? this.formstatus,
    );
  }
}