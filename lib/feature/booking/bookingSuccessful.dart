// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/responsiveconsultant.dart';
import 'package:naraakom/core/widgets/text700normal.dart';

import '../../core/widgets/text400normal.dart';
import '../../core/widgets/text600normal.dart';

class bookingSuccessful extends StatefulWidget {
  ConsultantModel consultant;
  String dateAndTime;
  String appointmentType;
  bookingSuccessful(
      {super.key,
      required this.consultant,
      required this.dateAndTime,
      required this.appointmentType});

  @override
  State<bookingSuccessful> createState() => _bookingSuccessfulState();
}

class _bookingSuccessfulState extends State<bookingSuccessful> {
  String image = '';
  @override
  void initState() {
    super.initState();
    if (widget.appointmentType == 'videocall') {
      image = 'videocall.svg';
    } else if (widget.appointmentType == 'voicecall') {
      image = 'voicecall.svg';
    } else {
      image = 'chatcall.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: white,
      body: Directionality(
          textDirection:
              defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: size.height * .05,
              ),
              child: Column(children: [
                Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/success.svg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: text700normal(
                          text: language[defaultLang]['thankyou'],
                          fontsize: 24,
                          color: cyan)),
                  Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      child: text600normal(
                          text: language[defaultLang]['yourappointmentcreated'],
                          fontsize: 18,
                          color: darkblack)),
                ]),
                _spacer(5, size),
                _title(language[defaultLang]['bookinginformations'], size),
                responiveconsultant(
                    islarge: false,
                    consultant: widget.consultant,
                    onClick: () {}),
                _spacer(2, size),
                _bookingInfo(size),
                _myScheduleButton(size)
              ]),
            ),
          )),
    );
  }

  _myScheduleButton(Size size) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: button(
            text: language[defaultLang]['myschedule'],
            width: size.width,
            onTap: () {
              Navigator.pushReplacementNamed(context, homePageRoute);
            }));
  }

  _spacer(double height, Size size) {
    return Container(
      height: height,
      color: lightcyan,
      width: size.width,
    );
  }

  _title(String text, Size size) {
    return Container(
        margin: const EdgeInsets.only(left: 16, right: 5, top: 16),
        width: size.width,
        child: text700normal(text: text, fontsize: 20, color: darkblack));
  }

  _bookingInfo(Size size) {
    return Container(
      height: 304,
      width: size.width,
      margin: const EdgeInsets.all(16),
      child: Column(children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: homebackgrey,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14))),
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: white),
                  child: SvgPicture.asset('assets/images/money.svg'),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(children: [
                        text400normal(
                            text: language[defaultLang]['price'],
                            fontsize: 16,
                            color: darkblack),
                        const Spacer()
                      ]),
                      const Spacer(),
                      Row(children: [
                        text600normal(
                            text: '150 QAR', fontsize: 16, color: cyan),
                        const Spacer()
                      ]),
                    ],
                  ),
                ))
          ]),
        ),
        _spacer(2, size),
        Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: homebackgrey,
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: white),
                  child: SvgPicture.asset('assets/images/iconschedule.svg'),
                )),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              text400normal(
                                  text: language[defaultLang]['datetime'],
                                  fontsize: 16,
                                  color: darkblack),
                              const Spacer()
                            ],
                          ),
                          Row(
                            children: [
                              text400normal(
                                  text: 'Monday, 20 Agu 2023, 08:00 PM',
                                  fontsize: 12,
                                  color: darkblack),
                              const Spacer()
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ]),
        ),
        _spacer(2, size),
        Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: homebackgrey,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14))),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.all(0),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: white),
                  child: SvgPicture.asset(
                    'assets/images/$image',
                    width: 30,
                    height: 30,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          text400normal(
                              text: language[defaultLang]['appointmenttype'],
                              fontsize: 16,
                              color: darkblack),
                          const Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          text400normal(
                              text: widget.appointmentType,
                              fontsize: 14,
                              color: lightblack),
                          const Spacer()
                        ],
                      )
                    ],
                  ),
                ))
          ]),
        ),
      ]),
    );
  }
}
