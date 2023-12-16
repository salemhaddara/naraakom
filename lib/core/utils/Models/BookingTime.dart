// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

class BookingTime {
  DateTime bookingtime;
  bool active, available;
  int doctor_id, day_index;
  String from_hour;

  BookingTime(
      {required this.bookingtime,
      required this.active,
      required this.doctor_id,
      required this.day_index,
      required this.from_hour,
      required this.available});
  static BookingTime fromJson(Map<String, dynamic> json, DateTime time) {
    return BookingTime(
      bookingtime: setDateWithSpecificHour(json['from_hour'], time),
      active: json['active'] == 1,
      doctor_id: json['doctor_id'],
      day_index: json['day_index'],
      from_hour: json['from_hour'],
      available: json['available'] == 'true',
    );
  }

  static List<BookingTime> parseBookingTimes(String jsonStr, DateTime time) {
    Map<String, dynamic> jsonData = json.decode(jsonStr);
    List<dynamic> dataList = jsonData['data'];

    return dataList.map((data) => BookingTime.fromJson(data, time)).toList();
  }

  static DateTime setDateWithSpecificHour(
      String hourString, DateTime specificDate) {
    List<String> hourParts = hourString.split(':');
    int hour = int.parse(hourParts[0]);
    int minute = int.parse(hourParts[1]);

    return DateTime(
      specificDate.year,
      specificDate.month,
      specificDate.day,
      hour,
      minute,
    );
  }
}
