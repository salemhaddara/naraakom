// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authRepository.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/feature/profile/profileStatus/profilestatus.dart';
import 'package:naraakom/feature/profile/profilestates/profile_event.dart';
import 'package:naraakom/feature/profile/profilestates/profile_state.dart';

class profile_bloc extends Bloc<profile_event, profile_state> {
  authRepository repo;
  profile_bloc(this.repo) : super(profile_state(status: initialstatus())) {
    on<logout>(
      (event, emit) async {
        emit(profile_state(status: logoutLoading()));
        var result = await repo.logout();
        if (result['status'] == 'success') {
          emit(profile_state(status: logoutSuccess()));
        } else {
          emit(profile_state(status: logoutfailed(result['message'])));
        }
      },
    );
    on<getLanguage>(
      (event, emit) async {
        emit(profile_state(
            status: initialstatus(),
            chosenLanguage: await Preferences.getlang()));
      },
    );
  }
}
