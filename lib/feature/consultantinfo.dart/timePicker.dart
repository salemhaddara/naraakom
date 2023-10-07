import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/BookingTime.dart';

class TimePicker extends StatefulWidget {
  final List<BookingTIme> strings;
  final Function(DateTime) onTimeSelected;

  const TimePicker(
      {Key? key, required this.strings, required this.onTimeSelected})
      : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.start,
        children: widget.strings.map((string) {
          final time = string.bookingtime;
          final isSelected = selectedTime == time;

          return GestureDetector(
            onTap: () {
              if (!string.isBooked) {
                setState(() {
                  selectedTime = time;
                });
                widget.onTimeSelected(time);
              }
            },
            child: Container(
              width: 100.0,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? lightcyan : Colors.transparent,
                border: Border.all(
                  color: string.isBooked
                      ? Colors.grey
                      : Colors.blue, // Highlight available times
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  formatDateTimeToString(time),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.black
                        : (string.isBooked ? Colors.grey : Colors.black),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String formatDateTimeToString(DateTime dateTime) {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }
}
