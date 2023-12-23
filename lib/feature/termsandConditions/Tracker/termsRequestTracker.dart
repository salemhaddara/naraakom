// ignore_for_file: file_names,camel_case_types

abstract class termsRequestTracker {}

class termsRequestLoading extends termsRequestTracker {}

class termsRequestFailed extends termsRequestTracker {
  String exception;
  termsRequestFailed(this.exception);
}

class termsRequestSuccess extends termsRequestTracker {}
