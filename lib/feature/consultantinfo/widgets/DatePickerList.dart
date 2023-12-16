// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerList extends StatelessWidget {
  final int itemCount;
  final Function(DateTime) onDateSelected;
  final DateTime? selectedDate;

  const DatePickerList({
    super.key,
    required this.itemCount,
    required this.onDateSelected,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final day = DateTime.now().add(Duration(days: index + 1));
          final dayName = DateFormat('E').format(day);
          final date = day.day.toString();
          final isSelected =
              selectedDate != null && isSameDay(day, selectedDate!);

          return GestureDetector(
            onTap: () {
              onDateSelected(day);
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
