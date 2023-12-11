// ignore_for_file: camel_case_types

import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/User.dart';

abstract class consultantsrequeststate {}

class consultantsrequest_INITIAL extends consultantsrequeststate {}

class consultantsrequest_IN_PROGRESS extends consultantsrequeststate {}

class consultantsrequest_SUCCESS extends consultantsrequeststate {
  List<ConsultantModel> consultants;
  consultantsrequest_SUCCESS({required this.consultants});
}

class consultantsrequest_FAILED extends consultantsrequeststate {
  String exception;
  consultantsrequest_FAILED({required this.exception});
}

class userDataRequest_IN_PROGRESS extends consultantsrequeststate {}

class userDataRequest_SUCCESS extends consultantsrequeststate {
  User userdata;
  userDataRequest_SUCCESS({required this.userdata});
}

class userDataRequest_FAILED extends consultantsrequeststate {
  Exception exception;
  userDataRequest_FAILED({required this.exception});
}

class CategorySelectedState extends consultantsrequeststate {
  final String selectedCategory;
  final List<ConsultantModel> filteredList;

  CategorySelectedState(this.selectedCategory, this.filteredList);
}

class SearchState extends consultantsrequeststate {
  final String text;
  final List<ConsultantModel> searchedconsultants;

  SearchState(this.text, this.searchedconsultants);
}
