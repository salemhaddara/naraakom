abstract class loginevent {}

class loginPhoneNumberChanged extends loginevent {
  final String? phoneNumnber;
  loginPhoneNumberChanged({required this.phoneNumnber});
}

class loginPasswordrChanged extends loginevent {
  final String? password;
  loginPasswordrChanged({required this.password});
}

class loginSubmitted extends loginevent {}
