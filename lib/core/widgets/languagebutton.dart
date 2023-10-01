import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/buttontext.dart';

class Languagebutton extends StatelessWidget {
  final bool isEnglish;
  final String text;
  final bool isChosen;
  final VoidCallback onTap;
  const Languagebutton(
      {super.key,
      required this.isEnglish,
      required this.text,
      required this.isChosen,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(13)),
      onTap: onTap,
      child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          elevation: 2,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  color: isChosen ? cyan : white,
                  border: Border.all(
                      color: isChosen ? cyan : lightblack, width: 1)),
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  SvgPicture.asset(
                    isEnglish
                        ? 'assets/images/english.svg'
                        : 'assets/images/arabic.svg',
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  buttontext(
                    text: text,
                    isChosen: isChosen,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
