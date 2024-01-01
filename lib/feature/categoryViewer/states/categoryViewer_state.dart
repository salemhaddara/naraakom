// ignore_for_file: camel_case_types,file_names

import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/feature/categoryViewer/tracker/category_requestTracker.dart';

class categoryViewer_state {
  List<ConsultantModel>? consultants = List.empty(growable: true);
  List<ConsultantModel>? showedconsultants = List.empty(growable: true);
  category_requestTracker? tracker = categoryRequestInitialState();
  categoryViewer_state(
      {this.consultants, this.tracker, this.showedconsultants});
  categoryViewer_state copyWith(
      {List<ConsultantModel>? consultants,
      List<ConsultantModel>? showedconsultants,
      category_requestTracker? tracker}) {
    return categoryViewer_state(
      consultants: consultants ?? this.consultants,
      tracker: tracker ?? this.tracker,
      showedconsultants: showedconsultants ?? this.showedconsultants,
    );
  }
}
