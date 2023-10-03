import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/core/widgets/responsiveconsultant.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/home/homecomponents/autoslider.dart';
import 'package:naraakom/feature/home/homecomponents/popularbar.dart';
import 'package:naraakom/feature/notifications/notificationScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import 'homecomponents/sliderbutton.dart';

// ignore: camel_case_types
class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<homeScreen> {
  int yourActiveIndex = 0;
  String name = 'Nada';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    name = 'Nada';
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: white,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: Directionality(
        textDirection:
            defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: cyan,
                expandedHeight: size.height * 0.12,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: SizedBox(),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHomeTopBar(size),
                ),
              ),
            ];
          },
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _slider(size),
                    _categories(size),
                    _divider(10),
                    popularbar(
                      width: size.width,
                      height: 50,
                    ),
                    responiveconsultant(islarge: false),
                    responiveconsultant(islarge: false),
                    _ad(size)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ad(Size size) {
    return AspectRatio(
      aspectRatio: 14 / 7,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: Stack(
                  children: <Widget>[
                    // Background Image
                    Image.asset(
                      'assets/images/ad.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    Positioned(
                      top: 20,
                      left: 20,
                      child: SizedBox(
                        height: constraints.maxHeight / 2,
                        width: constraints.maxWidth / 2 + 50,
                        child: Column(
                          children: [
                            Expanded(
                              child: text700normal(
                                text: 'The Best Consultant for your Life',
                                fontsize: 16,
                                color: darkblack,
                              ),
                            ),
                            Expanded(
                              child: text400normal(
                                text: 'To follow up via a voice or video call',
                                fontsize: 14,
                                color: darkblack,
                                align: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Position the "Book Now" text at the bottom-left corner
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: sliderbutton(
                        text: 'Book Now',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _divider(double height) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: height,
      color: homebackgrey,
    );
  }

  Widget _categories(Size size) {
    String assetprefix = 'assets/images/';
    return Container(
      margin: const EdgeInsets.only(top: 20),
      color: homebackgrey,
      child: Column(
        children: [
          _categoryRow(
            size,
            '${assetprefix}familyconsultant.svg',
            language[defaultLang]['familyconsultant'],
            '${assetprefix}professionalconsultant.svg',
            language[defaultLang]['professionalconsultant'],
            '${assetprefix}educationnalconsultant.svg',
            language[defaultLang]['educationnalconsultant'],
          ),
          _categoryRow(
            size,
            '${assetprefix}behaviorconsultant.svg',
            language[defaultLang]['behaviorconsultant'],
            '${assetprefix}psychologicalconsultant.svg',
            language[defaultLang]['psychologicalconsultant'],
            '${assetprefix}humandevelopment.svg',
            language[defaultLang]['humandevelopment'],
          ),
        ],
      ),
    );
  }

  Widget _categoryRow(Size size, image1, text1, image2, text2, image3, text3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _categoryContainer(size, image1, text1),
        _categoryContainer(size, image2, text2),
        _categoryContainer(size, image3, text3)
      ],
    );
  }

  Widget _categoryContainer(Size size, String image, String text) {
    return Container(
      width: ((size.width / 3) - 30),
      height: ((size.width / 3) - 30),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: white,
          border: Border.all(color: lightblack, width: 0.2),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(children: [
        Expanded(flex: 2, child: SvgPicture.asset(image)),
        Expanded(
            child: text700normal(
          text: text,
          fontsize: 12,
          color: darkblack,
          align: TextAlign.center,
        ))
      ]),
    );
  }

  Widget _slider(Size size) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 15), child: const AutoSlider()),
      ],
    );
  }

  Widget _buildHomeTopBar(Size size) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      width: size.width,
      height: size.height * 0.15,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bar.png',
              width: size.width,
              height: size.height * 0.20,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight * 0.3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/images/logoimagewhite.svg',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.2,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    text600normal(
                                      text:
                                          '${language[defaultLang]['hello']} $name ',
                                      fontsize: 20,
                                      color: white,
                                      align: TextAlign.start,
                                    ),
                                    SvgPicture.asset('assets/images/imoji.svg'),
                                  ],
                                ),
                              ),
                              text400normal(
                                text:
                                    '${language[defaultLang]['haveaniceday']} $name',
                                color: white,
                                fontsize: 13,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const notificationScreen(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Container(
                            height: 33,
                            width: 33,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: white),
                            child: Stack(children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                      'assets/images/notification.svg')),
                              Container(
                                height: 8,
                                width: 8,
                                margin: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    color: Colors.red),
                              )
                            ]),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}