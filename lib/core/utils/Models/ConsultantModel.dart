// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/core/utils/Models/department.dart';
import 'package:naraakom/feature/splash/splash.dart';

class ConsultantModel {
  String name,
      user_type,
      address,
      profile,
      photo,
      certificate,
      passport_id,
      created,
      nationality_title_en,
      nationality_title_ar,
      specialitst_title_ar,
      specialitst_title_en,
      city_title_en,
      city_title_ar,
      country_title_en,
      country_title_ar,
      bio,
      availability;
  double fees, rate;
  String date_birth;
  int visitors,
      user_id,
      city_id,
      nationality_id,
      specialist_id,
      country_id,
      experience_yrs,
      doctor_verified;
  List<department> departments = List.empty();
  ConsultantModel(
      {required this.name,
      required this.user_type,
      required this.address,
      required this.profile,
      required this.photo,
      required this.certificate,
      required this.passport_id,
      required this.created,
      required this.experience_yrs,
      required this.nationality_title_en,
      required this.nationality_title_ar,
      required this.city_title_en,
      required this.city_title_ar,
      required this.country_title_en,
      required this.country_title_ar,
      required this.specialitst_title_ar,
      required this.specialitst_title_en,
      required this.fees,
      required this.rate,
      required this.date_birth,
      required this.visitors,
      required this.user_id,
      required this.city_id,
      required this.nationality_id,
      required this.specialist_id,
      required this.country_id,
      required this.doctor_verified,
      required this.bio,
      required this.departments,
      required this.availability});
  static List<ConsultantModel> parseConsultantModels(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    final List<dynamic> consultantsData = data['data'];

    List<ConsultantModel> consultants = [];
    for (var consultantData in consultantsData) {
      consultants.add(
        ConsultantModel(
            name: consultantData['name'],
            user_type: consultantData['user_type'].toString(),
            address: consultantData['address'],
            profile: consultantData['profile'],
            photo: consultantData['photo'],
            bio: consultantData['bio'] ?? '',
            rate: consultantData['rate'] + 0.0,
            certificate: consultantData['certificate'],
            passport_id: consultantData['passport_id'],
            created: consultantData['created'],
            nationality_title_en: consultantData['nationality_title_en'],
            nationality_title_ar: consultantData['nationality_title_ar'],
            city_title_en: consultantData['city_title_en'],
            city_title_ar: consultantData['city_title_ar'],
            experience_yrs: (consultantData['experience_yrs']) ?? 0,
            country_title_en: consultantData['country_title_en'],
            country_title_ar: consultantData['country_title_ar'],
            fees: double.parse(consultantData['fees']),
            date_birth: consultantData['date_birth'],
            visitors: consultantData['visitors'],
            user_id: consultantData['user_id'],
            city_id: consultantData['city_id'],
            nationality_id: consultantData['nationality_id'],
            specialist_id: consultantData['specialist_id'],
            country_id: consultantData['country_id'],
            doctor_verified: consultantData['doctor_verified'],
            specialitst_title_ar: consultantData['specialitst_title_ar'],
            specialitst_title_en: consultantData['specialitst_title_en'],
            departments: department.parseDepartments(jsonString),
            availability: concatAvailability(
              convertTimeFormat(
                  consultantData['startHour']['start_from'] ?? ''),
              convertTimeFormat(consultantData['toHour']['end_to'] ?? ''),
            )),
      );
    }
    return consultants;
  }

  static concatAvailability(String fromHour, String toHour) {
    return '${language[defaultLang]['from']} $fromHour ${language[defaultLang]['to']} $toHour';
  }

  static String convertTimeFormat(String timeString) {
    List<String> timeParts = timeString.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    String amPm = hour < 12 ? 'AM' : 'PM';

    hour = hour % 12;
    if (hour == 0) {
      hour = 12;
    }
    return '$hour:${minute.toString().padLeft(2, '0')} $amPm';
  }
}
