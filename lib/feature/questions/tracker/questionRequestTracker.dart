// ignore_for_file: file_names, camel_case_types

abstract class questionsRequestTracker {}

class questionsInitialState extends questionsRequestTracker {}

class loadingQuestionsFetch extends questionsRequestTracker {}

class successQuestionsFetch extends questionsRequestTracker {}

class failedQuestionsFetch extends questionsRequestTracker {
  String exception;
  failedQuestionsFetch({required this.exception});
}
