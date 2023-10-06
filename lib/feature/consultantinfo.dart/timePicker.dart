import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naraakom/core/utils/Models/BookingTime.dart';

class TimePicker extends StatelessWidget {
  final List<BookingTIme> strings;
  final Function(DateTime) onTimeSelected;

  const TimePicker(
      {super.key, required this.strings, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.start,
        children: strings.map((string) {
          final time = string.bookingtime;
          final isSelected = string.isBooked;

          return GestureDetector(
            onTap: () {
              if (!isSelected) {
                onTimeSelected(time);
              }
            },
            child: Container(
              width: 120.0,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
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
                    color: isSelected ? Colors.grey : Colors.black,
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
