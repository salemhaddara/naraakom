// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/core/utils/Models/faqQuestion.dart';
import 'package:naraakom/feature/questions/Repo/questionsRepo.dart';
import 'package:naraakom/feature/questions/states/questions_event.dart';
import 'package:naraakom/feature/questions/states/questions_state.dart';
import 'package:naraakom/feature/questions/tracker/questionRequestTracker.dart';
import 'package:naraakom/feature/splash/splash.dart';

class questions_bloc extends Bloc<questions_event, questions_state> {
  questionsRepo repo;
  questions_bloc(this.repo) : super(questions_state()) {
    on<questionFetchRequest>(
      (event, emit) async {
        var response = await repo.getAllQuestions();
        if (response['status'] == 'success') {
          emit(state.copyWith(
              allQuestions: faqQuestion.transformJsonToQuestions(response),
              tracker: successQuestionsFetch()));
        } else {
          emit(state.copyWith(
              tracker: failedQuestionsFetch(
                  exception: response['message_$defaultLang'])));
        }
      },
    );
  }
}
