// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/department.dart';
import 'package:naraakom/feature/splash/splash.dart';

class specializationsView extends StatelessWidget {
  final List<department> texts;

  const specializationsView({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: texts.map((text) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: lightcyan,
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            defaultLang == 'en' ? text.title_en : text.title_ar,
            style: GoogleFonts.nunitoSans(fontSize: 16, color: cyan),
          ),
        );
      }).toList(),
    );
  }
}
