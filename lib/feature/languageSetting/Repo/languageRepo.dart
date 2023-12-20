// ignore_for_file: camel_case_types,file_names

import 'package:naraakom/core/utils/Preferences/Preferences.dart';

class languageRepo {
  Future<String> getLanguage() async {
    return await Preferences.getlang() ?? 'en';
  }

  Future<bool> setLanguage(String language) async {
    return await Preferences.savelang(language);
  }
}
