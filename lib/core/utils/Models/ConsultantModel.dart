// ignore_for_file: non_constant_identifier_names

import 'package:naraakom/core/utils/Models/BookingTime.dart';

class ConsultantModel {
  String name, category, availability, biography, id;
  double rating, consultation_rate, experience;
  int visitors;
  List<String> specializations = List.empty(growable: true);
  List<BookingTIme> bookedTimes = List.empty(growable: true);
  ConsultantModel(
      {required this.name,
      required this.category,
      required this.id,
      required this.availability,
      required this.rating,
      required this.consultation_rate,
      required this.visitors,
      required this.experience,
      required this.biography,
      required this.specializations,
      required this.bookedTimes});
}
