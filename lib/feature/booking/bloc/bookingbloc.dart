// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/feature/booking/Repository/bookingappointmentRepo.dart';
import 'package:naraakom/feature/booking/bloc/bookingevent.dart';
import 'package:naraakom/feature/booking/bloc/bookingstate.dart';

class bookingAppointmentbloc
    extends Bloc<bookingAppointmentevent, bookingAppointmentstate> {
  bookingappointmentRepo repo;
  bookingAppointmentbloc(this.repo) : super(bookingAppointmentstate(index: 0)) {
    on<bookingSchemaIndexChanged>(
      (event, emit) {
        int index = repo.handleContinueButton(state.index);

        emit(state.copywith(index: index));
      },
    );
    on<bookingSchemaCancelInvoked>(
      (event, emit) {
        int index = repo.handleCancelButton(state.index);
        emit(state.copywith(index: index));
      },
    );
    on<submitContactInfo>(
      (event, emit) {
        emit(state.copywith(
            name: event.name,
            email: event.email,
            phoneNumber: event.phoneNumber));
      },
    );
    on<submitPaymentMethod>(
      (event, emit) {},
    );
  }
}
