// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/category.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/feature/home/mainbloc/Repository/repository.dart';
import 'package:naraakom/feature/home/mainbloc/contentevent.dart';
import 'package:naraakom/feature/home/mainbloc/contentstate.dart';
import 'package:naraakom/feature/home/mainbloc/state/specialistsrequeststate.dart';
import 'package:naraakom/feature/splash/splash.dart';

import 'state/consultantsrequeststate.dart';

class contentbloc extends Bloc<contentevent, contentstate> {
  final Repository repo;
  contentbloc(this.repo) : super(contentstate()) {
    //GET CONSULTANTS DATA
    on<ConsultantsRequested>(
      (event, emit) async {
        try {
          emit(state.copyWith(userName: await Preferences.getUserName()));
          //fetch data here
          emit(state.copyWith(requeststate: consultantsrequest_IN_PROGRESS()));
          var response = await repo.fetchConsultants();
          if (response['status'] == 'success') {
            List<ConsultantModel> consultants =
                response['data'] as List<ConsultantModel>;
            emit(state.copyWith(
                consultants: consultants,
                requeststate:
                    consultantsrequest_SUCCESS(consultants: consultants)));
          } else {
            emit(state.copyWith(
                requeststate: consultantsrequest_FAILED(
                    exception: (await httpHelper
                        .returnServerError())['message_$defaultLang'])));
          }
        } catch (e) {
          emit(state.copyWith(
              requeststate: consultantsrequest_FAILED(
                  exception: (await httpHelper
                      .returnServerError())['message_$defaultLang'])));
        }
      },
    );
    on<SpecialistsRequested>((event, emit) async {
      emit(state.copyWith(
          specialistsrequestTracker: specialistsFetchingLOADING()));
      var response = await repo.fetchCategories();
      if (response['status'] == 'success') {
        List<category> categories = response['data'] as List<category>;
        emit(state.copyWith(
            categories: categories,
            specialistsrequestTracker: specialistsFetchingSUCCESSFUL()));
      } else {
        emit(state.copyWith(
            specialistsrequestTracker:
                specialistsFetchingFAILED(response['message_$defaultLang'])));
      }
    });
    // on<SelectCategoryEvent>((event, emit) {
    //   List<ConsultantModel> list =
    //       state.consultants ?? List.empty(growable: true);
    //   final filteredList = list.where((item) {
    //     return item.category == event.selectedCategory;
    //   }).toList();
    //   if (event.selectedCategory == 'all') {
    //     filteredList.clear();
    //     filteredList.addAll(list);
    //   }

    //   emit(state.copyWith(
    //       requeststate:
    //           CategorySelectedState(event.selectedCategory, filteredList)));
    // });
    // on<SearchtextChangedEvent>((event, emit) {
    //   List<ConsultantModel> list =
    //       state.consultants ?? List.empty(growable: true);
    //   List<ConsultantModel> filteredList = list.where((item) {
    //     return item.category == event.selectedCategory;
    //   }).toList();
    //   if (event.selectedCategory == 'all') {
    //     filteredList.clear();
    //     filteredList.addAll(list);
    //   }
    //   if (event.text != null && event.text!.isNotEmpty) {
    //     filteredList = filteredList.where((element) {
    //       return (element.name.toLowerCase()).contains((event.text!));
    //     }).toList();
    //   }
    //   emit(state.copyWith(
    //       requeststate: SearchState(event.selectedCategory, filteredList)));
    // });
  }
}
