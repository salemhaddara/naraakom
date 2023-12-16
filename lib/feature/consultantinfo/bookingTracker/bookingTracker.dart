// ignore_for_file: file_names, camel_case_types

abstract class bookingTracker {}

class selectDateLoading extends bookingTracker {}

class selectDateFailed extends bookingTracker {
  String exception;
  selectDateFailed(this.exception);
}

class selectDateSuccess extends bookingTracker {}
