import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/core/widgets/languagebutton.dart';
import 'package:naraakom/core/widgets/text600normal.dart';

// ignore: camel_case_types
class chooseLangScreen extends StatefulWidget {
  const chooseLangScreen({super.key});

  @override
  State<chooseLangScreen> createState() => _chooseLangScreenState();
}

// ignore: camel_case_types
class _chooseLangScreenState extends State<chooseLangScreen> {
  int langindex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: size.width,
                height: size.height * .65,
                child: Image.asset(
                  'assets/images/langback.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: size.width,
                height: size.height * .45,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26)),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26))),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Hero(
                            tag: 'logo',
                            child: SvgPicture.asset('assets/images/logo.svg')),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: size.width,
                            child: text600normal(
                              text: 'Choose Language',
                              color: lightblack,
                              fontsize: 20,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Languagebutton(
                          text: 'English',
                          isEnglish: true,
                          isChosen: true,
                          onTap: () async {
                            if (await Preferences.savelang('en')) {
                              defaultLang = 'en';
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(
                                  context, loginRoute);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Languagebutton(
                            text: 'Arabic',
                            isEnglish: false,
                            isChosen: false,
                            onTap: () async {
                              if (await Preferences.savelang('ar')) {
                                defaultLang = 'ar';
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(
                                    context, loginRoute);
                              }
                            })
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
