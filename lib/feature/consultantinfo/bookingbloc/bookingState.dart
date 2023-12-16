// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

import 'package:naraakom/core/utils/Models/BookingTime.dart';
import 'package:naraakom/feature/consultantinfo/bookingTracker/bookingTracker.dart';

class bookingstate {
  List<BookingTime>? timesAvailable = List<BookingTime>.empty(growable: true);
  DateTime? Selected;
  bookingTracker? tracker;
  bookingstate({this.timesAvailable, this.Selected, this.tracker});
  bookingstate copyWith({
    List<BookingTime>? timesAvailable,
    DateTime? Selected,
    bookingTracker? tracker,
  }) {
    return bookingstate(
      timesAvailable: timesAvailable ?? this.timesAvailable,
      Selected: Selected ?? this.Selected,
      tracker: tracker ?? this.tracker,
    );
  }
}
