// ignore_for_file: camel_case_types

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

class checkUserExistance extends loginevent {
  String phoneNumber;
  checkUserExistance(this.phoneNumber);
}
