// ignore_for_file: camel_case_types, file_names

import 'package:naraakom/feature/splash/splash.dart';

class faqQuestion {
  int id, active;
  String q, answer;
  faqQuestion(this.id, this.active, this.q, this.answer);
  static List<faqQuestion> transformJsonToQuestions(
      Map<String, dynamic> jsonData) {
    List<faqQuestion> questions = [];

    if (jsonData.containsKey("data")) {
      List<dynamic> data = jsonData["data"];
      for (var item in data) {
        int id = item["id"];
        int active = item["active"];
        String q = item["q_$defaultLang"];
        String answer = item["answer_$defaultLang"];

        faqQuestion question = faqQuestion(id, active, q, answer);
        questions.add(question);
      }
    }

    return questions;
  }
}
