// ignore_for_file: file_names, camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/feature/personalDetails/Repo/personalDetailsRepo.dart';
import 'package:naraakom/feature/personalDetails/states/personalDetails_event.dart';
import 'package:naraakom/feature/personalDetails/states/personalDetails_state.dart';
import 'package:naraakom/feature/personalDetails/tracker/personalDetailsTracker.dart';

class personalDetails_bloc
    extends Bloc<personalDetails_event, personalDetails_state> {
  personalDetailsRepo repo;
  personalDetails_bloc(this.repo) : super(personalDetails_state()) {
    on<fetchDetails>(
      (event, emit) async {
        var response = await repo.fetchData();
        emit(state.copyWith(
          userName: response['name'],
          phoneNumber: response['phoneNumber'],
          password: response['password'],
          emailAddress: response['email'],
          tracker: fetchedData(),
        ));
      },
    );
    on<updateDetails>(
      (event, emit) {},
    );
  }
}
