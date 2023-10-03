abstract class otpevent {}

class otpPhoneNumberChanged extends otpevent {
  final String? phoneNumber;
  otpPhoneNumberChanged({required this.phoneNumber});
}

class otpcodeChanged extends otpevent {
  final String? code;
  otpcodeChanged({required this.code});
}

class otpcodeprovidedChanged extends otpevent {
  final String? codeprovided;
  otpcodeprovidedChanged({required this.codeprovided});
}

class otpSubmitted extends otpevent {}

class otpVerifyClicked extends otpevent {}