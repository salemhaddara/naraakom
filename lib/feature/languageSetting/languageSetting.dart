// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/MyNavigationBar.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/languageSetting/Components/languageItem.dart';
import 'package:naraakom/feature/languageSetting/Repo/languageRepo.dart';
import 'package:naraakom/feature/languageSetting/state/language_bloc.dart';
import 'package:naraakom/feature/languageSetting/state/language_event.dart';
import 'package:naraakom/feature/languageSetting/state/language_state.dart';
import 'package:naraakom/feature/splash/splash.dart';

class languageSetting extends StatefulWidget {
  const languageSetting({super.key});

  @override
  State<languageSetting> createState() => _languageSettingState();
}

class _languageSettingState extends State<languageSetting> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
              language_bloc(context.read<languageRepo>())..add(getLanguage()),
          child: SafeArea(
            child: BlocBuilder<language_bloc, language_state>(
                builder: (context, state) {
              return Directionality(
                textDirection:
                    defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  children: [
                    _topBar(size),
                    _devider(),
                    _title(size),
                    _languageItems()
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  _languageItems() {
    return BlocBuilder<language_bloc, language_state>(
        builder: (context, state) {
      return Column(
        children: [
          languageItem(
              isChosen: state.chosenLanguage == 'en',
              photo: 'english',
              text: 'English',
              onClick: () {
                context.read<language_bloc>().add(setLanguage('en'));
              }),
          languageItem(
              isChosen: state.chosenLanguage == 'ar',
              photo: 'arabic',
              text: 'العربية',
              onClick: () {
                context.read<language_bloc>().add(setLanguage('ar'));
              }),
        ],
      );
    });
  }

  _title(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(16),
      child: text400normal(
        text: language[defaultLang]['changelanguage'],
        color: darkblack,
        align: TextAlign.start,
        fontsize: 16,
      ),
    );
  }

  _devider() {
    return Container(
      height: 10,
      color: homebackgrey,
      margin: const EdgeInsets.only(top: 5),
    );
  }

  _topBar(Size size) {
    return Material(
      elevation: 1,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24))),
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MyNavigationBar(index: 3);
              }));
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Transform.rotate(
                angle: defaultLang == 'ar' ? 3.14159265 : 0,
                child: SvgPicture.asset(
                  'assets/images/back.svg',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: text600normal(
              text: '${language[defaultLang]['language']}',
              fontsize: 20,
              color: lightblack,
            ),
          )
        ]),
      ),
    );
  }
}
