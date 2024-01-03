// ignore_for_file: file_names, camel_case_types

class bookingappointmentRepo {
  int handleContinueButton(int index) {
    if (index < 3) {
      return index + 1;
    }
    return 0;
  }

  int handleCancelButton(int index) {
    if (index > 0) {
      return index - 1;
    }
    return 0;
  }
}
