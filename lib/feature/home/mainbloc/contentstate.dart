// ignore_for_file: camel_case_types

import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/feature/home/mainbloc/state/consultantsrequeststate.dart';

class contentstate {
  List<ConsultantModel>? consultants = List.empty(growable: true);
  final consultantsrequeststate? requeststate;
  final User? userdata;
  final String? userName;
  contentstate({
    this.consultants,
    this.requeststate,
    this.userdata,
    this.userName,
  });
  contentstate copyWith(
      {List<ConsultantModel>? consultants,
      consultantsrequeststate? requeststate,
      User? userdata,
      String? userName}) {
    return contentstate(
        consultants: consultants ?? this.consultants,
        requeststate: requeststate ?? this.requeststate,
        userName: userName ?? this.userName,
        userdata: userdata ?? this.userdata);
  }
}
