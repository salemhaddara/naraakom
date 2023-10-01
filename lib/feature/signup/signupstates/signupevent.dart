abstract class signupevent {}

class signupPhoneNumberChanged extends signupevent {
  final String? phoneNumnber;
  signupPhoneNumberChanged({required this.phoneNumnber});
}

class signupPasswordrChanged extends signupevent {
  final String? password;
  signupPasswordrChanged({required this.password});
}

class signupNameChanged extends signupevent {
  final String? name;
  signupNameChanged({required this.name});
}

class signupEmailChanged extends signupevent {
  final String? email;
  signupEmailChanged({required this.email});
}

class signupSubmitted extends signupevent {}
