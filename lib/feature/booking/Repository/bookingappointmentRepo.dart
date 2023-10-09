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
