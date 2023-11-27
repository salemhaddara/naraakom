// ignore_for_file: camel_case_types

abstract class otpsubmissionstatus {
  const otpsubmissionstatus();
}

class initialotpformstatus extends otpsubmissionstatus {
  const initialotpformstatus();
}

class otpformsubmitting extends otpsubmissionstatus {}

class otpsendingsuccess extends otpsubmissionstatus {}

class otpvalidationsuccess extends otpsubmissionstatus {
  String message;
  otpvalidationsuccess(this.message);
}

class otpsendingfailed extends otpsubmissionstatus {
  final String exception;
  const otpsendingfailed(this.exception);
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
