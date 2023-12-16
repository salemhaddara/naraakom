// ignore_for_file: camel_case_types, non_constant_identifier_names

abstract class bookingevent {}

class getTimesinSpecificDate extends bookingevent {
  final DateTime? dateTime;
  int doctor_id;
  getTimesinSpecificDate(this.dateTime, this.doctor_id);
}
