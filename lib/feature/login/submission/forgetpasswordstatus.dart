// ignore_for_file: camel_case_types

abstract class forgetPasswordStatus {
  const forgetPasswordStatus();
}

class userexist extends forgetPasswordStatus {}

class initialStatusForgetPassword extends forgetPasswordStatus {
  const initialStatusForgetPassword();
}

class userdoesnotexist extends forgetPasswordStatus {
  String exception;
  userdoesnotexist(this.exception);
}
