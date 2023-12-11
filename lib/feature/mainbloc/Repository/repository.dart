import 'dart:io';

import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/BookingTime.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

class Repository {
  Future<Map<String, dynamic>> fetchConsultants() async {
    List<ConsultantModel> consultants = [];
    try {
      var response = await http.get(Uri.parse(apiDoctors),
          headers: await httpHelper.getHeaderwithToken());
      //parse response and after it add connsultants to list
      return {'status': 'success', 'data': consultants};
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }

  List<BookingTIme> getbookingsTimes(DateTime date) {
    List<BookingTIme> bookedtimes = [
      BookingTIme(
          bookingtime: DateTime(date.year, date.month, 8, 10, 30),
          isBooked: true)
    ];
    List<BookingTIme> bookingtimes = [];

    final startTime = DateTime(date.year, date.month, date.day, 10, 0);
    final endTime = DateTime(date.year, date.month, date.day, 15, 0);

    var currentTime = startTime;
    while (currentTime.isBefore(endTime)) {
      final isBooked = bookedtimes.any((bookedTime) {
        return currentTime.isAtSameMomentAs(bookedTime.bookingtime);
      });

      bookingtimes
          .add(BookingTIme(bookingtime: currentTime, isBooked: isBooked));

      currentTime = currentTime.add(const Duration(minutes: 30));
    }

    return bookingtimes;
  }
}
