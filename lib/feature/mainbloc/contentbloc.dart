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
            userdata: user,
            requeststate: userDataRequest_SUCCESS(userdata: user)));
      } catch (e) {
        emit(state.copyWith(
            requeststate: userDataRequest_FAILED(exception: e as Exception)));
      }
    });
    on<SelectCategoryEvent>((event, emit) {
      List<ConsultantModel> list =
          state.consultants ?? List.empty(growable: true);
      final filteredList = list.where((item) {
        return item.category == event.selectedCategory;
      }).toList();
      if (event.selectedCategory == 'all') {
        filteredList.clear();
        filteredList.addAll(list);
      }

      emit(state.copyWith(
          requeststate:
              CategorySelectedState(event.selectedCategory, filteredList)));
    });
    on<SearchtextChangedEvent>((event, emit) {
      List<ConsultantModel> list =
          state.consultants ?? List.empty(growable: true);
      List<ConsultantModel> filteredList = list.where((item) {
        return item.category == event.selectedCategory;
      }).toList();
      if (event.selectedCategory == 'all') {
        filteredList.clear();
        filteredList.addAll(list);
      }
      if (event.text != null && event.text!.isNotEmpty) {
        filteredList = filteredList.where((element) {
          return (element.name.toLowerCase()).contains((event.text!));
        }).toList();
      }
      emit(state.copyWith(
          requeststate: SearchState(event.selectedCategory, filteredList)));
    });
  }
}
