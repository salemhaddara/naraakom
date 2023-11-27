import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';

class otpstate {
  final String phonenumber;
  final String verificationId;
  final int resendtoken;
  final String code;
  final String codeprovided;
  final bool isError;
  final otpsubmissionstatus formstatus;
  final String newPassword;
  final String UserId;
  otpstate({
    this.phonenumber = '',
    this.verificationId = '',
    this.resendtoken = 0,
    this.code = '',
    this.codeprovided = '',
    this.isError = false,
    this.newPassword = '',
    this.UserId = '',
    this.formstatus = const initialotpformstatus(),
  });

  otpstate copyWith({
    String? phonenumber,
    String? verificationId = '',
    int? resendtoken,
    String? code,
    String? codeprovided,
    bool? isError,
    String? newPassword,
    String? userId,
    otpsubmissionstatus? formstatus,
  }) {
    return otpstate(
      phonenumber: phonenumber ?? this.phonenumber,
      verificationId: verificationId ?? this.verificationId,
      resendtoken: resendtoken ?? this.resendtoken,
      code: code ?? this.code,
      codeprovided: codeprovided ?? this.codeprovided,
      isError: isError ?? this.isError,
      newPassword: newPassword ?? this.newPassword,
      UserId: userId ?? UserId,
      formstatus: formstatus ?? this.formstatus,
    );
  }
}
