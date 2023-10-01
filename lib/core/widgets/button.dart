import 'package:flutter/material.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/buttontext.dart';

class button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  const button(
      {super.key,
      required this.text,
      required this.width,
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
              width: width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                color: cyan,
              ),
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.center,
                child: buttontext(
                  text: text,
                  isChosen: true,
                ),
              ),
            ),
          )),
    );
  }
}
