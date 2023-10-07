import 'package:naraakom/core/utils/Models/BookingTime.dart';

class bookingstate {
  List<BookingTIme>? timesAvailable = List<BookingTIme>.empty(growable: true);
  DateTime? Selected;
  bookingstate({this.timesAvailable, this.Selected});
  bookingstate copyWith(
      {List<BookingTIme>? timesAvailable, DateTime? Selected}) {
    return bookingstate(
        timesAvailable: timesAvailable ?? this.timesAvailable,
        Selected: Selected ?? this.Selected);
  }
}
