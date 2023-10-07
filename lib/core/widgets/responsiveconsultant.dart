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
  Function onClick;
  Function? onclicknotlarge;
  responiveconsultant(
      {super.key,
      required this.islarge,
      required this.consultant,
      required this.onClick,
      this.onclicknotlarge});

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
          height: widget.islarge ? 322 : 100,
          child: Column(children: [
            GestureDetector(
              onTap: widget.onclicknotlarge == null
                  ? () {}
                  : () {
                      widget.onclicknotlarge!();
                    },
              child: SizedBox(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
            ),
            if (widget.islarge)
              SizedBox(
                height: 222,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      color: lightcyan,
                      height: 2,
                    ),
                    _row(
                        'specialist.svg',
                        '${widget.consultant.biography.substring(0, 45)}...',
                        false),
                    _row(
                        'money.svg',
                        'A consultant specializing in family counseling and improve relationships',
                        true),
                    _row('time.svg', widget.consultant.availability, false),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: button(
            text: language[defaultLang]['booknow'],
            width: double.infinity,
            onTap: () {
              widget.onClick();
            }));
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
              startText: '${language[defaultLang]['consultationprice']} :',
              clickableText:
                  '${widget.consultant.consultation_rate.floor()} QAR',
              onClick: () {},
              fontsize: 14,
            ))
          ]),
        ),
      );
    }
  }
}
