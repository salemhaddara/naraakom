// ignore_for_file: camel_case_types

import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/core/utils/Models/category.dart';
import 'package:naraakom/feature/home/tracker/consultantsrequeststate.dart';
import 'package:naraakom/feature/home/tracker/specialistsrequeststate.dart';

class contentstate {
  List<ConsultantModel>? consultants = List.empty(growable: true);
  List<category>? categories = List.empty(growable: true);
  final consultantsrequeststate? requeststate;
  final User? userdata;
  final String? userName;
  specialistsrequeststate? specialistsrequestTracker =
      specialistsFetchingINITIAL();

  contentstate(
      {this.consultants,
      this.requeststate,
      this.userdata,
      this.userName,
      this.specialistsrequestTracker,
      this.categories});
  contentstate copyWith(
      {List<ConsultantModel>? consultants,
      List<category>? categories,
      consultantsrequeststate? requeststate,
      User? userdata,
      String? userName,
      specialistsrequeststate? specialistsrequestTracker}) {
    return contentstate(
      consultants: consultants ?? this.consultants,
      requeststate: requeststate ?? this.requeststate,
      userName: userName ?? this.userName,
      userdata: userdata ?? this.userdata,
      specialistsrequestTracker:
          specialistsrequestTracker ?? this.specialistsrequestTracker,
      categories: categories ?? this.categories,
    );
  }
}
