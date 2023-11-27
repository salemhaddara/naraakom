import 'package:flutter/material.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/categoryViewer/CategoryViewer.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// ignore: camel_case_types, must_be_immutable
class popularbar extends StatelessWidget {
  double? width = 0;
  double? height = 0;
  popularbar({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: text700normal(
            color: darkblack,
            text: language[defaultLang]['popularconusltant'],
            fontsize: 18,
          )),
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: categoryViewer(
                  category: language['en']['familyconsultant'],
                  title: language[defaultLang]['familyconsultant'],
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: text400normal(
              text: language[defaultLang]['seeall'],
              color: cyan,
              fontsize: 14,
            ),
          )
        ],
      ),
    );
  }
}
