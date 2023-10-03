import 'package:flutter/material.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text600normal.dart';

class sliderbutton extends StatelessWidget {
  String? text = '';
  sliderbutton({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: text600normal(
          text: text ?? 'Explore Now',
          color: cyan,
          fontsize: 14,
        ));
  }
}
