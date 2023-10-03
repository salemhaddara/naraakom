import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/signup/signupcomponents/siginrichtext.dart';

// ignore: camel_case_types, must_be_immutable
class responiveconsultant extends StatefulWidget {
  bool islarge = false;
  ConsultantModel consultant;
  responiveconsultant(
      {super.key, required this.islarge, required this.consultant});

  @override
  State<responiveconsultant> createState() => _responiveconsultantState();
}

// ignore: camel_case_types
class _responiveconsultantState extends State<responiveconsultant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Material(
        elevation: 0,
        shadowColor: lightcyan,
        color: white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: SizedBox(
          height: widget.islarge ? 300 : 100,
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
                                text: widget.consultant.name,
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
                                text: widget.consultant.category,
                                fontsize: 14,
                                color: darkblack),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: AlignmentDirectional.centerStart,
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/rating.svg'),
                                text600normal(
                                    align: TextAlign.start,
                                    text: ' ${widget.consultant.rating} ',
                                    fontsize: 12,
                                    color: darkblack),
                                text400normal(
                                    align: TextAlign.start,
                                    text:
                                        '(${widget.consultant.visitors} Visitors)',
                                    fontsize: 12,
                                    color: darkblack),
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
            if (widget.islarge)
              SizedBox(
                height: 200,
                child: Column(
                  children: [
                    _row(
                        'specialist.svg',
                        'A consultant specializing in family counseling and improve relationships',
                        false),
                    _row(
                        'money.svg',
                        'A consultant specializing in family counseling and improve relationships',
                        true),
                    _row('time.svg', 'Available From 10 AM to 3 PM', false),
                    _button()
                  ],
                ),
              )
          ]),
        ),
      ),
    );
  }

  _button() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: button(
            text: language[defaultLang]['booknow'],
            width: double.infinity,
            onTap: () {}));
  }

  _row(String image, String text, bool isrichtext) {
    if (!isrichtext) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                'assets/images/$image',
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child:
                    text400normal(text: text, color: lightblack, fontsize: 14))
          ]),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            SvgPicture.asset(
              'assets/images/$image',
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: signinrichtext(
              startText: 'Consultation Price : ',
              clickableText: '150 QAR',
              onClick: () {},
              fontsize: 14,
            ))
          ]),
        ),
      );
    }
  }
}
