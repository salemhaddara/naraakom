// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';

class languageItem extends StatelessWidget {
  bool isChosen;
  String photo;
  String text;
  VoidCallback onClick;
  languageItem(
      {super.key,
      required this.isChosen,
      required this.photo,
      required this.text,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 54,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: isChosen ? lightcyan : white,
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            ),
            border: Border.all(color: isChosen ? cyan : homebackgrey)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset('assets/images/$photo.svg')),
            ),
            Expanded(
              flex: 3,
              child: text400normal(
                text: text,
                color: darkblack,
                fontsize: 16,
              ),
            ),
            Expanded(
                flex: 1,
                child: Center(
                  child: isChosen
                      ? Icon(
                          Icons.check,
                          color: cyan,
                        )
                      : Container(),
                )),
          ],
        ),
      ),
    );
  }
}
