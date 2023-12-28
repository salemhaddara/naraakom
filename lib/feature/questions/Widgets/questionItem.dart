// ignore_for_file: must_be_immutable, camel_case_types,file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/faqQuestion.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/feature/questions/Widgets/questionResponseScreen.dart';
import 'package:naraakom/feature/splash/splash.dart';

class questionItem extends StatelessWidget {
  Size size;
  faqQuestion question;
  questionItem({super.key, required this.size, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      constraints: const BoxConstraints(minHeight: 54, maxHeight: 100),
      decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          )),
      margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => questionResponseScreen(
                    question: question.q,
                    response: question.answer,
                  ))));
        },
        child: Row(children: [
          Expanded(
              child: text400normal(
            text: question.q,
            color: lightblack,
            fontsize: 16,
          )),
          SizedBox(
            width: 32,
            height: 32,
            child: Transform.rotate(
              angle: defaultLang == 'en' ? 3.14159265 : 0,
              child: SvgPicture.asset(
                'assets/images/back.svg',
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
