// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/feature/splash/splash.dart';

class schemaBooking extends StatelessWidget {
  int index;
  Size size;
  schemaBooking({super.key, required this.index, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16, bottom: 10),
      child: Row(children: [
        Expanded(
            child: Column(
          children: [
            if (index == 0)
              SvgPicture.asset(
                'assets/images/phone.svg',
                height: 24,
                width: 24,
              )
            else if (index > 0)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/phonegrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
                text: language[defaultLang]['calltype'],
                fontsize: 14,
                color: index >= 0 ? cyan : grey)
          ],
        )),
        Container(
          height: 1,
          width: 20,
          color: grey,
        ),
        Expanded(
            child: Column(
          children: [
            if (index == 1)
              SvgPicture.asset(
                'assets/images/contactinfo.svg',
                height: 24,
                width: 24,
              )
            else if (index > 1)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/contactinfogrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
              text: language[defaultLang]['contactinfo'],
              fontsize: 13,
              color: index >= 1 ? cyan : grey,
              align: TextAlign.center,
            ),
          ],
        )),
        Container(
          height: 1,
          width: 20,
          color: grey,
        ),
        Expanded(
            child: Column(
          children: [
            if (index == 2)
              SvgPicture.asset(
                'assets/images/case.svg',
                height: 24,
                width: 24,
              )
            else if (index > 2)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/casegrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
              text: language[defaultLang]['case'],
              fontsize: 14,
              color: index >= 2 ? cyan : grey,
            )
          ],
        )),
        Container(
          height: 1,
          width: 20,
          color: grey,
        ),
        Expanded(
            child: Column(
          children: [
            if (index == 3)
              SvgPicture.asset(
                'assets/images/payment.svg',
                height: 24,
                width: 24,
              )
            else if (index > 3)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/paymentgrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
              text: language[defaultLang]['payment'],
              fontsize: 14,
              color: index >= 3 ? cyan : grey,
            )
          ],
        )),
      ]),
    );
  }
}
