// ignore_for_file: must_be_immutable, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/splash/splash.dart';

class topBarBooking extends StatelessWidget {
  Size size;
  ConsultantModel consultantinfos;
  topBarBooking({super.key, required this.size, required this.consultantinfos});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
        child: Container(
            width: size.width,
            decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: text600normal(
                  text: '${language[defaultLang]['confirmbooking']}/',
                  fontsize: 20,
                  color: lightblack,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: text400normal(
                  text: consultantinfos.name,
                  fontsize: 20,
                  color: lightblack,
                ),
              ),
            ])));
  }
}
