// ignore_for_file: camel_case_types

import 'package:naraakom/feature/profile/profileStatus/profilestatus.dart';
import 'package:naraakom/feature/splash/splash.dart';

class profile_state {
  profilestatus status;
  String? chosenLanguage = defaultLang;
  profile_state({required this.status, this.chosenLanguage});
}
