import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/core/utils/Models/BookingTime.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/NotificationModel.dart';
import 'package:naraakom/core/utils/Models/ReviewModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'dart:core';

class Repository {
  Future<List<ConsultantModel>> fetchConsultants() async {
    List<ConsultantModel> consultants = [];
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    consultants.add(ConsultantModel(
        name: 'Salem Haddara',
        category: 'Family Consultant',
        availability: '8 AM to 10 PM',
        rating: 5,
        id: 'id3',
        consultation_rate: 250,
        visitors: 1000,
        experience: 3,
        biography:
            'Dedicated physician committed to improving lives through compassionate care. Extensive experience in diagnosing and treating a wide range of medical conditions. Strong advocate for patient education and empowerment. Committed to ongoing professional development to provide the highest quality of healthcare',
        specializations: [
          language[defaultLang]['familyconsultant'],
          language[defaultLang]['behaviorconsultant'],
          language[defaultLang]['educationnalconsultant'],
          language[defaultLang]['professionalconsultant']
        ],
        bookedTimes: [],
        reviews: [
          ReviewModel(
              User(
                  username: 'Salem Haddara',
                  id: 'id',
                  email: 'email',
                  password: 'password',
                  notifications: []),
              ' If you need a translation to a different language, please specify the target language, and I',
              3.6,
              DateTime.now()),
          ReviewModel(
              User(
                  username: 'Salem Haddara',
                  id: 'id',
                  email: 'email',
                  password: 'password',
                  notifications: []),
              ' If you need a translation to a different language, please specify the target language, and I',
              3.6,
              DateTime.now()),
          ReviewModel(
              User(
                  username: 'Salem Haddara',
                  id: 'id',
                  email: 'email',
                  password: 'password',
                  notifications: []),
              ' If you need a translation to a different language, please specify the target language, and I',
              3.6,
              DateTime.now())
        ]));
    consultants.add(ConsultantModel(
        name: 'Jean Paul',
        category: 'Family Consultant',
        availability: '8 AM to 10 PM',
        rating: 5,
        id: 'id4',
        consultation_rate: 350,
        visitors: 1000,
        biography:
            'Dedicated physician committed to improving lives through compassionate care. Extensive experience in diagnosing and treating a wide range of medical conditions. Strong advocate for patient education and empowerment. Committed to ongoing professional development to provide the highest quality of healthcare',
        experience: 5,
        specializations: [
          language[defaultLang]['familyconsultant'],
          language[defaultLang]['behaviorconsultant'],
          language[defaultLang]['educationnalconsultant'],
          language[defaultLang]['professionalconsultant']
        ],
        bookedTimes: [],
        reviews: [
          ReviewModel(
              User(
                  username: 'Salem Haddara',
                  id: 'id',
                  email: 'email',
                  password: 'password',
                  notifications: []),
              ' If you need a translation to a different language, please specify the target language, and I',
              3.6,
              DateTime.now()),
          ReviewModel(
              User(
                  username: 'Salem Haddara',
                  id: 'id',
                  email: 'email',
                  password: 'password',
                  notifications: []),
              ' If you need a translation to a different language, please specify the target language, and I',
              3.6,
              DateTime.now()),
          ReviewModel(
              User(
                  username: 'Salem Haddara',
                  id: 'id',
                  email: 'email',
                  password: 'password',
                  notifications: []),
              ' If you need a translation to a different language, please specify the target language, and I',
              3.6,
              DateTime.now())
        ]));
    return consultants;
  }

  Future<User> getUserWithId(String id) async {
    return User(
        username: 'Salem haddara',
        id: 'id',
        email: 'email',
        password: 'password',
        notifications: [
          NotificationModel(
              senderName: 'Salem Haddara',
              notificationtext: 'accepted your appointment',
              notificationtime: '10:00 AM',
              senderprofileURL: '',
              isRead: false)
        ]);
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
