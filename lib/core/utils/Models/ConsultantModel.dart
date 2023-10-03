import 'package:naraakom/core/utils/Models/BookingTime.dart';

class ConsultantModel {
  String name, category, availability, biography, id;
  double rating, consultation_rate;
  int visitors;
  List<String> specializations = List.empty(growable: true);
  List<BookingTIme> bookings = List.empty(growable: true);
  ConsultantModel(
      {required this.name,
      required this.category,
      required this.id,
      required this.availability,
      required this.rating,
      required this.consultation_rate,
      required this.visitors,
      required this.biography,
      required this.specializations,
      required this.bookings});
}
