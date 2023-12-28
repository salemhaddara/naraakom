// ignore_for_file: file_names, camel_case_types

import 'package:naraakom/feature/personalDetails/tracker/personalDetailsTracker.dart';

class personalDetails_state {
  String? userName, phoneNumber, emailAddress, password;
  personalDetailsTracker? tracker;
  personalDetails_state(
      {this.userName,
      this.phoneNumber,
      this.emailAddress,
      this.password,
      this.tracker});
  personalDetails_state copyWith({
    String? userName,
    String? phoneNumber,
    String? emailAddress,
    String? password,
    personalDetailsTracker? tracker,
  }) {
    return personalDetails_state(
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      tracker: tracker ?? this.tracker,
    );
  }
}
