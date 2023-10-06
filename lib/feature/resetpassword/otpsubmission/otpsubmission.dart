abstract class otpsubmissionstatus {
  const otpsubmissionstatus();
}

class initialotpformstatus extends otpsubmissionstatus {
  const initialotpformstatus();
}

class otpformsubmitting extends otpsubmissionstatus {}

class otpsubmissionsuccess extends otpsubmissionstatus {}

class otpsubmissionfailed extends otpsubmissionstatus {
  final Exception exception;
  const otpsubmissionfailed(this.exception);
}

abstract class otpverificationstatus {
  const otpverificationstatus();
}

class initialotpverifyButton extends otpverificationstatus {
  const initialotpverifyButton();
}

class otpverifying extends otpsubmissionstatus {}

class otpverifiyingsuccess extends otpsubmissionstatus {}

class otpverifiyingfailed extends otpsubmissionstatus {
  final Exception exception;
  const otpverifiyingfailed(this.exception);
}

class settingNewPasswordINPROGRESS extends otpsubmissionstatus {}

class settingNewPasswordSUCCESS extends otpsubmissionstatus {}

class settingNewPasswordFAILED extends otpsubmissionstatus {
  Exception exception;
  settingNewPasswordFAILED({required this.exception});
}
