abstract class signupsubmissionstatus {
  const signupsubmissionstatus();
}

class initialsignupformstatus extends signupsubmissionstatus {
  const initialsignupformstatus();
}

class signupformsubmitting extends signupsubmissionstatus {}

class signupsubmissionsuccess extends signupsubmissionstatus {}

class signupsubmissionfailed extends signupsubmissionstatus {
  final Exception exception;
  const signupsubmissionfailed(this.exception);
}
