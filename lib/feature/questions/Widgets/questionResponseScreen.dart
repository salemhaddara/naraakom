// ignore_for_file: camel_case_types,file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/topBar.dart';
import 'package:naraakom/feature/splash/splash.dart';

class questionResponseScreen extends StatelessWidget {
  String question, response;
  questionResponseScreen(
      {super.key, required this.question, required this.response});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Directionality(
        textDirection:
            defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            topBar(size: size, textResourceId: 'Privacy Policy'),
            Container(
                alignment: AlignmentDirectional.topStart,
                margin: const EdgeInsets.all(16),
                child: text600normal(
                    text: question, fontsize: 18, color: darkblack)),
            Divider(
              height: 2,
              color: grey,
            ),
            Container(
                margin: const EdgeInsets.all(16),
                alignment: AlignmentDirectional.topStart,
                child: text400normal(
                    text: response, color: lightblack, fontsize: 16))
          ],
        ),
      ),
    ));
  }
}
