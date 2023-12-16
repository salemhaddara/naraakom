// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/core/utils/Models/BookingTime.dart';
import 'package:naraakom/feature/consultantinfo/bookingTracker/bookingTracker.dart';
import 'package:naraakom/feature/consultantinfo/bookingbloc/bookingEvent.dart';
import 'package:naraakom/feature/consultantinfo/bookingbloc/bookingState.dart';
import 'package:naraakom/feature/consultantinfo/repo/bookingRepository.dart';
import 'package:naraakom/feature/splash/splash.dart';

class bookingbloc extends Bloc<bookingevent, bookingstate> {
  final bookingRepository repo;
  bookingbloc(this.repo) : super(bookingstate()) {
    on<getTimesinSpecificDate>(
      (event, emit) async {
        emit(state.copyWith(
            Selected: event.dateTime, tracker: selectDateLoading()));
        var response =
            await repo.getbookingsTimes(event.dateTime!, event.doctor_id);
        List<BookingTime> bookingtimes = [];
        if (response['status'] == 'success') {
          bookingtimes.addAll(response['data']);
        } else {
          emit(state.copyWith(
              tracker: selectDateFailed(
            response['message_$defaultLang'],
          )));
        }

        emit(state.copyWith(
          timesAvailable: bookingtimes,
          Selected: event.dateTime,
          tracker: selectDateSuccess(),
        ));
      },
    );
  }
}
