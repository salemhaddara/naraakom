// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

import 'dart:convert';
import 'dart:io';

import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/BookingTime.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

class bookingRepository {
  Future<Map<String, dynamic>> getbookingsTimes(
    DateTime date,
    int doctor_id,
  ) async {
    List<BookingTime> bookingtimes = [];

    try {
      var response = await http.post(Uri.parse(apicheckDoctorAppointment),
          body: json.encode({
            'doctor_id': doctor_id,
            'day_index': getDayIndexFromDate(date),
            'date': formatDate(date)
          }),
          headers: await httpHelper.getHeaderwithToken());
      print(json.decode(response.body));
      bookingtimes = (BookingTime.parseBookingTimes(response.body, date));
      //remove not active bookingtimes
      bookingtimes.removeWhere((time) => !time.active);
      bookingtimes.sort(
          (time1, time2) => time1.bookingtime.compareTo(time2.bookingtime));

      return {'status': 'success', 'data': bookingtimes};
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }

  String formatDate(DateTime time) {
    return '${time.year}-${time.month}-${time.day}';
  }

  int getDayIndexFromDate(DateTime date) {
    return date.weekday % 7;
  }
}
