// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/feature/termsandConditions/Repo/termsAndConditionsRepo.dart';
import 'package:naraakom/feature/termsandConditions/States/termsAndconditions_State.dart';
import 'package:naraakom/feature/termsandConditions/States/termsAndconditions_event.dart';
import 'package:naraakom/feature/termsandConditions/Tracker/termsRequestTracker.dart';

class termsAndconditions_bloc
    extends Bloc<termsAndconditions_event, termsAndconditions_State> {
  termsAndConditionsRepo repo;
  termsAndconditions_bloc(this.repo)
      : super(termsAndconditions_State(
          termsAndconditions_TEXT: null,
          lastUpdate: null,
          tracker: termsRequestLoading(),
        )) {
    on<request_termsAndconditions>(
      (event, emit) async {
        var response = await repo.getTermsAndConditions();
        if (response['status'] == 'success') {
          emit(
            termsAndconditions_State(
              termsAndconditions_TEXT: response['data']['content_$defaultLang'],
              lastUpdate:
                  convertUpdatedAtToDate(response['data']['updated_at']),
              tracker: termsRequestSuccess(),
            ),
          );
        } else {
          emit(
            termsAndconditions_State(
              termsAndconditions_TEXT: '',
              lastUpdate: null,
              tracker: termsRequestFailed(response['message_$defaultLang']),
            ),
          );
        }
      },
    );
  }
  String convertUpdatedAtToDate(String updatedAt) {
    DateTime updatedAtDateTime = DateTime.parse(updatedAt);

    String formattedDate =
        '${updatedAtDateTime.day}/${updatedAtDateTime.month}/${updatedAtDateTime.year}';

    return formattedDate;
  }
}
