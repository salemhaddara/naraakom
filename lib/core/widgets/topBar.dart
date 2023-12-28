// ignore_for_file: camel_case_types, must_be_immutable,file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/splash/splash.dart';

class topBar extends StatelessWidget {
  Size size;
  String textResourceId;
  Color? backColor;
  topBar(
      {super.key,
      required this.size,
      required this.textResourceId,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backColor ?? Colors.transparent,
      child: Material(
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
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Transform.rotate(
                  angle: defaultLang == 'ar' ? 3.14159265 : 0,
                  child: SvgPicture.asset(
                    'assets/images/back.svg',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: text600normal(
                text: '${language[defaultLang][textResourceId]}',
                fontsize: 20,
                color: lightblack,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
