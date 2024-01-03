// ignore_for_file: camel_case_types

class bookingAppointmentstate {
  int index;
  int? age;
  String? callType, name, email, phoneNumber, caseDescription;
  //Constructor
  bookingAppointmentstate({
    this.index = 0,
    this.callType,
    this.name,
    this.email,
    this.phoneNumber,
    this.age,
    this.caseDescription,
  });
  //copy With Function
  bookingAppointmentstate copywith({
    int? index,
    String? callType,
    String? name,
    String? email,
    String? phoneNumber,
    int? age,
    String? caseDescription,
  }) {
    return bookingAppointmentstate(
      index: index ?? this.index,
      callType: callType ?? this.callType,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      caseDescription: caseDescription ?? this.caseDescription,
    );
  }
}
