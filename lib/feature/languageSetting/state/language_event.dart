// ignore_for_file: camel_case_types

abstract class language_event {}

class getLanguage extends language_event {}

class setLanguage extends language_event {
  String language;
  setLanguage(this.language);
}
