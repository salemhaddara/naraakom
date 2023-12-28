// ignore_for_file: camel_case_types

import 'package:naraakom/core/utils/Models/faqQuestion.dart';
import 'package:naraakom/feature/questions/tracker/questionRequestTracker.dart';

class questions_state {
  List<faqQuestion>? allQuestions = List.empty(growable: true);
  questionsRequestTracker? tracker = questionsInitialState();
  questions_state({this.allQuestions, this.tracker});
  questions_state copyWith(
      {List<faqQuestion>? allQuestions, questionsRequestTracker? tracker}) {
    return questions_state(
        allQuestions: allQuestions ?? this.allQuestions,
        tracker: tracker ?? this.tracker);
  }
}
