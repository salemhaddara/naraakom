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

class saveUserPhoneNumber extends otpevent {
  final String? phoneNumber;
  saveUserPhoneNumber({required this.phoneNumber});
}

class newPassChanged extends otpevent {
  final String? newPass;
  newPassChanged({required this.newPass});
}
