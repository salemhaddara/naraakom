import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/feature/consultantinfo.dart/bookingbloc/bookingEvent.dart';
import 'package:naraakom/feature/consultantinfo.dart/bookingbloc/bookingState.dart';
import 'package:naraakom/feature/mainbloc/Repository/repository.dart';

class bookingbloc extends Bloc<bookingevent, bookingstate> {
  final Repository repo;
  bookingbloc(this.repo) : super(bookingstate()) {
    on<getTimesinSpecificDate>(
      (event, emit) {
        emit(state.copyWith(
            timesAvailable: repo.getbookingsTimes(event.dateTime!),
            Selected: event.dateTime));
      },
    );
  }
}
