// ignore_for_file: camel_case_types

abstract class submissionstatus {
  const submissionstatus();
}

class initialformstatus extends submissionstatus {
  const initialformstatus();
}

class formsubmitting extends submissionstatus {}

class submissionsuccess extends submissionstatus {
  String message;
  submissionsuccess(this.message);
}

class requiredValidation extends submissionstatus {
  String phoneNumber;
  requiredValidation(this.phoneNumber);
}

class submissionfailed extends submissionstatus {
  final String exception;
  const submissionfailed(this.exception);
}
