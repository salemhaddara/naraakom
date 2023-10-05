import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naraakom/config/theme/colors.dart';

class DatePickerList extends StatelessWidget {
  final int itemCount;
  final Function(DateTime) onDateSelected;

  const DatePickerList({
    super.key,
    required this.itemCount,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final day = DateTime.now().add(Duration(days: index));
          final dayName =
              DateFormat('E').format(day); // Get day name (e.g., "Mon")
          final date = day.day.toString(); // Get day of the month (e.g., "1")

          return GestureDetector(
            onTap: () {
              onDateSelected(day);
            },
            child: Container(
              width: 100, // Adjust the width as needed
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: cyan, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: darkblack),
                  ),
                  Text(date,
                      style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: darkblack)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
