// ignore_for_file: camel_case_types

import 'package:naraakom/core/utils/Models/PaymentMethod.dart';

abstract class bookingAppointmentevent {}

class bookingSchemaIndexChanged extends bookingAppointmentevent {}

class bookingSchemaCancelInvoked extends bookingAppointmentevent {}

class submitContactInfo extends bookingAppointmentevent {
  String name, email, phoneNumber;
  submitContactInfo({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class submitCaseInfo extends bookingAppointmentevent {
  String age, caseDescription;
  submitCaseInfo({
    required this.age,
    required this.caseDescription,
  });
}

class submitPaymentMethod extends bookingAppointmentevent {
  PaymentMethod method;
  submitPaymentMethod({
    required this.method,
  });
}
