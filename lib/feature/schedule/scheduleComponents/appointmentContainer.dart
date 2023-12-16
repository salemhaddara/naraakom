// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/core/utils/Models/Schedule.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';

import '../../../config/theme/colors.dart';

class appointmentContainer extends StatefulWidget {
  Schedule schedule;
  Function onJoinClicked;
  Function onCancelClicked;

  Size size;
  appointmentContainer(
      {super.key,
      required this.schedule,
      required this.onJoinClicked,
      required this.onCancelClicked,
      required this.size});

  @override
  State<appointmentContainer> createState() => _appointmentContainerState();
}

class _appointmentContainerState extends State<appointmentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Material(
        elevation: 4,
        shadowColor: lightcyan,
        color: white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: SizedBox(
          height: 250,
          child: Column(children: [
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 72,
                      width: 67,
                      decoration: BoxDecoration(
                          color: lightcyan,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.asset(
                          'assets/images/sample.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: AlignmentDirectional.centerStart,
                            child: text600normal(
                                align: TextAlign.start,
                                text: widget.schedule.consultant.name,
                                fontsize: 16,
                                color: darkblack),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: AlignmentDirectional.centerStart,
                            child: text400normal(
                                align: TextAlign.start,
                                text: widget.schedule.consultant.profile,
                                fontsize: 14,
                                color: lightblack),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            _spacer(0.2, widget.size),
            _scheduleInfo(widget.size),
            if (widget.schedule.status == 'canceled' ||
                widget.schedule.status == 'completed')
              _bookAgain(widget.size),
            if (widget.schedule.status == 'confirmed')
              _controlSchedule(widget.size)
          ]),
        ),
      ),
    );
  }

  _bookAgain(Size size) {
    return Container(
      width: size.width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: cyan,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/bookagain.svg'),
                const SizedBox(
                  width: 5,
                ),
                text400normal(
                    text: language[defaultLang]['bookagain'],
                    color: white,
                    fontsize: 14)
              ],
            ),
          )),
        ],
      ),
    );
  }

  _controlSchedule(Size size) {
    return Container(
      width: size.width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: cyan,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/joinwhite.svg'),
                const SizedBox(
                  width: 5,
                ),
                text400normal(
                    text: language[defaultLang]['join'],
                    color: white,
                    fontsize: 14)
              ],
            ),
          )),
          Expanded(
              child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: white,
                border: Border.all(color: cyan, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/cancel.svg'),
                const SizedBox(
                  width: 5,
                ),
                text400normal(
                    text: language[defaultLang]['cancel'],
                    color: cyan,
                    fontsize: 14)
              ],
            ),
          )),
        ],
      ),
    );
  }

  _scheduleInfo(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: size.width,
      height: 75,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/iconschedule.svg',
                height: 24,
                width: 24,
              ),
              const SizedBox(
                width: 5,
              ),
              text400normal(
                  text: formatDate(widget.schedule.scheduleTime),
                  color: lightblack,
                  fontsize: 14)
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/time.svg',
                height: 22,
                width: 22,
              ),
              const SizedBox(
                width: 5,
              ),
              text400normal(
                  text: formatTime(widget.schedule.scheduleTime),
                  color: lightblack,
                  fontsize: 14)
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                widget.schedule.status == 'confirmed' ||
                        widget.schedule.status == 'completed'
                    ? 'assets/images/confirmed.svg'
                    : 'assets/images/canceled.svg',
                height: 8,
                width: 8,
              ),
              const SizedBox(
                width: 5,
              ),
              text400normal(
                  text: widget.schedule.status, color: lightblack, fontsize: 14)
            ],
          ),
        )
      ]),
    );
  }

  _spacer(double height, Size size) {
    return Container(
      height: height,
      color: lightblack,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }
}
