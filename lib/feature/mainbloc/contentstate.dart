import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';
import 'package:naraakom/feature/mainbloc/state/consultantsrequeststate.dart';

class contentstate {
  List<ConsultantModel>? consultants = List.empty(growable: true);
  final consultantsrequeststate? requeststate;
  final User? userdata;
  contentstate({
    this.consultants,
    this.requeststate,
    this.userdata,
  });
  contentstate copyWith(
      {List<ConsultantModel>? consultants,
      consultantsrequeststate? requeststate,
      User? userdata}) {
    return contentstate(
        consultants: consultants ?? this.consultants,
        requeststate: requeststate ?? this.requeststate,
        userdata: userdata ?? this.userdata);
  }
}
