import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/NotificationModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';

class Repository {
  Future<List<ConsultantModel>> fetchConsultants() async {
    List<ConsultantModel> consultants = [];
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    consultants.add(ConsultantModel(
        name: 'Salem Haddara',
        category: 'Family Consulting',
        availability: '8 AM to 10 PM',
        rating: 5,
        id: 'id3',
        consultation_rate: 250,
        visitors: 1000,
        experience: 3,
        biography: 'later',
        specializations: [],
        bookings: []));
    consultants.add(ConsultantModel(
        name: 'Salem Haddara',
        category: 'Family Consulting',
        availability: '8 AM to 10 PM',
        rating: 5,
        id: 'id4',
        consultation_rate: 250,
        visitors: 1000,
        biography: 'later',
        experience: 5,
        specializations: [],
        bookings: []));
    return consultants;
  }

  Future<User> getUserWithId(String id) async {
    Future.delayed(const Duration(milliseconds: 1000));
    return User(
        username: 'username',
        id: 'id',
        email: 'email',
        password: 'password',
        notifications: [
          NotificationModel(
              senderName: 'Salem Haddara',
              notificationtext: 'notificationtext',
              notificationtime: '10 AM',
              senderprofileURL: '',
              isRead: false)
        ]);
  }
}
