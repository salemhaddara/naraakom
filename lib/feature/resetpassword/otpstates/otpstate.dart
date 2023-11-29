import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';

class otpstate {
  final String phonenumber;
  final String verificationId;
  final int resendtoken;
  final String codeprovided;
  final otpsubmissionstatus formstatus;
  final String newPassword;
  otpstate({
    this.phonenumber = '',
    this.verificationId = '',
    this.resendtoken = 0,
    this.codeprovided = '',
    this.newPassword = '',
    this.formstatus = const initialotpformstatus(),
  });

  otpstate copyWith({
    String? phonenumber,
    String? verificationId,
    int? resendtoken,
    String? codeprovided,
    String? newPassword,
    String? userId,
    otpsubmissionstatus? formstatus,
  }) {
    return otpstate(
      phonenumber: phonenumber ?? this.phonenumber,
      verificationId: verificationId ?? this.verificationId,
      resendtoken: resendtoken ?? this.resendtoken,
      codeprovided: codeprovided ?? this.codeprovided,
      newPassword: newPassword ?? this.newPassword,
      formstatus: formstatus ?? this.formstatus,
    );
  }
}
