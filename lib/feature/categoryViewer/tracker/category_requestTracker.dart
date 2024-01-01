// ignore_for_file: file_names,camel_case_types

abstract class category_requestTracker {}

class categoryRequestInitialState extends category_requestTracker {}

class categoryRequestLoading extends category_requestTracker {}

class categoryRequestFailed extends category_requestTracker {
  String exception;
  categoryRequestFailed({required this.exception});
}

class categoryRequestSuccess extends category_requestTracker {}
