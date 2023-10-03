import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/feature/mainbloc/Repository/repository.dart';
import 'package:naraakom/feature/mainbloc/contentevent.dart';
import 'package:naraakom/feature/mainbloc/contentstate.dart';

import 'state/consultantsrequeststate.dart';

class contentbloc extends Bloc<contentevent, contentstate> {
  final Repository repo;
  contentbloc(this.repo) : super(contentstate()) {
    //GET CONSULTANTS DATA
    on<ConsultantsRequested>(
      (event, emit) async {
        try {
          //fetch data here
          emit(state.copyWith(requeststate: consultantsrequest_IN_PROGRESS()));
          List<ConsultantModel> consultants = await repo.fetchConsultants();
          emit(state.copyWith(
              consultants: consultants,
              requeststate:
                  consultantsrequest_SUCCESS(consultants: consultants)));
        } catch (e) {
          emit(state.copyWith(
              requeststate:
                  consultantsrequest_FAILED(exception: e as Exception)));
        }
      },
    );
    //GET USER DATA
    on<UserDataRequested>((event, emit) async {
      try {
        emit(state.copyWith(requeststate: userDataRequest_IN_PROGRESS()));
        User user = await repo.getUserWithId('id');
        emit(state.copyWith(
            requeststate: userDataRequest_SUCCESS(userdata: user)));
      } catch (e) {
        emit(state.copyWith(
            requeststate: userDataRequest_FAILED(exception: e as Exception)));
      }
    });
  }
}
