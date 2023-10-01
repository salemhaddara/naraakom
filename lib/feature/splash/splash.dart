import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';

import '../../core/widgets/text400normal.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    initializePage();
  }

  void initializePage() async {
    if (await Preferences.langexist()) {
      defaultLang = (await Preferences.getlang())!;
    }

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        animate = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.pushReplacementNamed(context, chooselangRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: cyan,
    ));
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/splashback.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          const Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(alignment: Alignment.center, child: MyAnimatedContainer())
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class MyAnimatedContainer extends StatefulWidget {
  const MyAnimatedContainer({super.key});

  @override
  _MyAnimatedContainerState createState() => _MyAnimatedContainerState();
}

class _MyAnimatedContainerState extends State<MyAnimatedContainer> {
  bool _isAnimated = false;

  void _startAnimation() {
    setState(() {
      _isAnimated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      _startAnimation();
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: SvgPicture.asset(
              'assets/images/logowhite.svg',
              height: 80,
              width: 300,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            height: _isAnimated ? 200.0 : 0.0,
            width: 300.0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _isAnimated ? 1.0 : 0.0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    child: Text(
                      'شريكك في الصحة النفسية',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.tajawal(
                          color: white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  AnimatedOpacity(
                    opacity: _isAnimated ? 1.0 : 0.0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    child: text400normal(
                      text: 'Your Partner In Mental Health',
                      fontsize: 15,
                      color: white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
