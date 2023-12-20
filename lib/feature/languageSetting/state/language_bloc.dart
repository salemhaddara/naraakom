// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/feature/languageSetting/Repo/languageRepo.dart';
import 'package:naraakom/feature/languageSetting/state/language_event.dart';
import 'package:naraakom/feature/languageSetting/state/language_state.dart';
import 'package:naraakom/feature/splash/splash.dart';

class language_bloc extends Bloc<language_event, language_state> {
  final languageRepo repo;
  language_bloc(this.repo) : super(language_state()) {
    on<getLanguage>(
      (event, emit) async {
        emit(language_state(chosenLanguage: await repo.getLanguage()));
      },
    );
    on<setLanguage>(
      (event, emit) async {
        await repo.setLanguage(event.language);
        defaultLang = event.language;
        emit(language_state(chosenLanguage: await repo.getLanguage()));
      },
    );
  }
}
