import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final List<String> strings;

  const TimePicker({Key? key, required this.strings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Use the full available width
      padding: const EdgeInsets.all(16.0), // Add padding to the container
      child: Wrap(
        spacing: 16.0, // Horizontal spacing between items
        runSpacing: 16.0, // Vertical spacing between items
        alignment: WrapAlignment.start, // Align items to the start
        children: strings.map((string) {
          return Container(
            width: 120.0, // Set a fixed width for each item
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                string,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
