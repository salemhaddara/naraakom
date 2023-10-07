import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naraakom/config/localisation/translation.dart';

// ignore: camel_case_types
class text700normal extends StatelessWidget {
  final String? text;
  final double fontsize;
  final Color color;
  final TextAlign? align;
  const text700normal({
    super.key,
    required this.text,
    required this.fontsize,
    required this.color,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: align ?? TextAlign.start,
      style: defaultLang == 'en'
          ? GoogleFonts.nunitoSans(
              fontSize: fontsize,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: color)
          : GoogleFonts.tajawal(
              fontSize: fontsize,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: color),
    );
  }
}
