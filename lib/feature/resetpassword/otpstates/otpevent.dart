// ignore_for_file: camel_case_types

abstract class otpevent {}

class otpPhoneNumberChanged extends otpevent {
  final String? phoneNumber;
  otpPhoneNumberChanged({required this.phoneNumber});
}

class otpcodeprovidedChanged extends otpevent {
  final String? codeprovided;
  otpcodeprovidedChanged({required this.codeprovided});
}

class otpRequested extends otpevent {}

class otpVerifyClicked extends otpevent {}

class newPassSubmitted extends otpevent {}

class userIdChanged extends otpevent {
  final String? userId;
  userIdChanged({required this.userId});
}

class newPassChanged extends otpevent {
  final String? newPass;
  newPassChanged({required this.newPass});
}
