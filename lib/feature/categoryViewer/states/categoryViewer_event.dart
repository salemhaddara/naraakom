// ignore_for_file: camel_case_types,file_names, non_constant_identifier_names

abstract class categoryViewer_event {}

class fetchSpecificConsultantsRequest extends categoryViewer_event {
  int specialist_id;
  fetchSpecificConsultantsRequest({required this.specialist_id});
}

class performSearch extends categoryViewer_event {
  String searchText;
  performSearch(this.searchText);
}
