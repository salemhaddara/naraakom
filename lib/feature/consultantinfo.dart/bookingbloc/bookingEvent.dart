abstract class bookingevent {}

class getTimesinSpecificDate extends bookingevent {
  final DateTime? dateTime;
  getTimesinSpecificDate(this.dateTime);
}
