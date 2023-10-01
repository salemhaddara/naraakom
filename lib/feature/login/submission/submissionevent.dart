abstract class submissionstatus {
  const submissionstatus();
}

class initialformstatus extends submissionstatus {
  const initialformstatus();
}

class formsubmitting extends submissionstatus {}

class submissionsuccess extends submissionstatus {}

class submissionfailed extends submissionstatus {
  final Exception exception;
  const submissionfailed(this.exception);
}
