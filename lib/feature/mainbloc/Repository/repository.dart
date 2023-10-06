import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/NotificationModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';

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
        bookedTimes: []));
    consultants.add(ConsultantModel(
        name: 'Jean Paul',
        category: 'Family Consulting',
        availability: '8 AM to 10 PM',
        rating: 5,
        id: 'id4',
        consultation_rate: 250,
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
        bookedTimes: []));
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
              notificationtext: 'accepted your appointment',
              notificationtime: '10:00 AM',
              senderprofileURL: '',
              isRead: false)
        ]);
  }
}
