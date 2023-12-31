// ignore_for_file: camel_case_types,file_names

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/feature/categoryViewer/Repo/categoryViewerRepo.dart';
import 'package:naraakom/feature/categoryViewer/states/categoryViewer_event.dart';
import 'package:naraakom/feature/categoryViewer/states/categoryViewer_state.dart';
import 'package:naraakom/feature/categoryViewer/tracker/category_requestTracker.dart';
import 'package:naraakom/feature/splash/splash.dart';

import '../../../core/utils/Constants/categoriesFilters.dart';

class categoryViewer_bloc
    extends Bloc<categoryViewer_event, categoryViewer_state> {
  categoryViewerRepo repo;
  categoryViewer_bloc(this.repo) : super(categoryViewer_state()) {
    on<fetchSpecificConsultantsRequest>(
      (event, emit) async {
        emit(state.copyWith(tracker: categoryRequestLoading()));
        var response = await repo.getConsultantsWithThisId(event.specialist_id);
        if (response['status'] == 'success') {
          List<ConsultantModel> consultants =
              ConsultantModel.parseConsultantModels(json.encode(response));
          emit(state.copyWith(
              consultants: consultants,
              showedconsultants: consultants,
              tracker: categoryRequestSuccess()));
        } else {
          emit(state.copyWith(
              tracker: categoryRequestFailed(
                  exception: response['message_$defaultLang'])));
        }
      },
    );
    on<performSearch>(
      (event, emit) {
        if (event.searchText.isNotEmpty &&
            state.consultants != null &&
            state.consultants!.isNotEmpty) {
          emit(state.copyWith(
              showedconsultants: state.consultants!
                  .where((element) =>
                      (element.name.toLowerCase()).contains(event.searchText))
                  .toList()));
        } else {
          emit(state.copyWith(showedconsultants: state.consultants));
        }
      },
    );
    on<performSorting>(
      (event, emit) {
        switch (event.sort) {
          case HIGHEST_PRICE:
            state.consultants!.sort((e1, e2) => e1.fees.compareTo(e2.fees));
            emit(state.copyWith(consultants: state.consultants));
            break;
          case HIGHEST_RATE:
            state.consultants!.sort((e1, e2) => e2.rate.compareTo(e1.rate));
            emit(state.copyWith(consultants: state.consultants));
            break;
          case LOWEST_PRICE:
            state.consultants!.sort((e1, e2) => e2.fees.compareTo(e1.fees));
            emit(state.copyWith(consultants: state.consultants));
            break;
        }
      },
    );
  }
}
