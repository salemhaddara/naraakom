import 'package:naraakom/core/utils/Models/BookingTime.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';

import 'dart:core';

class Repository {
  Future<List<ConsultantModel>> fetchConsultants() async {
    List<ConsultantModel> consultants = [];
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    return consultants;
  }

  // Future<User> getUserWithId(String id) async {
  //   return User(
  //       username: 'Salem haddara',
  //       id: 'id',
  //       email: 'email',
  //       password: 'password',
  //       notifications: [
  //         NotificationModel(
  //             senderName: 'Salem Haddara',
  //             notificationtext: 'accepted your appointment',
  //             notificationtime: '10:00 AM',
  //             senderprofileURL: '',
  //             isRead: false)
  //       ]);
  // }

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
