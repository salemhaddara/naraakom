import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/chats/conversationsScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';

// ignore: camel_case_types
class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

// ignore: camel_case_types
class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: homebackgrey,
      body: Directionality(
        textDirection:
            defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: cyan,
                expandedHeight: size.height * 0.08,
                centerTitle: false,
                title: text700normal(
                  text: language[defaultLang]['myaccount'],
                  color: white,
                  fontsize: 22,
                ),
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
                    _accountTitle(language[defaultLang]['Personalization']),
                    _accountTile(
                      size,
                      'profile.svg',
                      language[defaultLang]['Profile'],
                      true,
                      false,
                      () {},
                    ),
                    _accountTile(
                      size,
                      'language.svg',
                      language[defaultLang]['Language'],
                      false,
                      false,
                      () {},
                    ),
                    _accountTile(
                      size,
                      'wallet.svg',
                      language[defaultLang]['Wallet'],
                      false,
                      false,
                      () {},
                    ),
                    _accountTile(
                      size,
                      'chats.svg',
                      language[defaultLang]['Chats'],
                      false,
                      true,
                      () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const conversationsScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    _accountTitle(language[defaultLang]['About']),
                    _accountTile(
                        size,
                        'help.svg',
                        language[defaultLang]['Help Center'],
                        true,
                        false,
                        () {}),
                    _accountTile(
                        size,
                        'terms.svg',
                        language[defaultLang]['Terms of use'],
                        false,
                        false,
                        () {}),
                    _accountTile(
                        size,
                        'privacypolicy.svg',
                        language[defaultLang]['Privacy Policy'],
                        false,
                        true,
                        () {}),
                    _logoutbutton(size)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoutbutton(Size size) {
    return Container(
      height: 54,
      width: size.width,
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        SvgPicture.asset('assets/images/logout.svg'),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: text400normal(
          text: language[defaultLang]['logout'],
          color: lightblack,
          fontsize: 16,
        )),
      ]),
    );
  }

  Widget _accountTile(Size size, String image, String text, bool radiustop,
      bool radiusdown, Function onTap) {
    return Container(
      height: 54,
      width: size.width,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiustop ? 10 : 0),
            topRight: Radius.circular(radiustop ? 10 : 0),
            bottomLeft: Radius.circular(radiustop ? 0 : 10),
            bottomRight: Radius.circular(radiustop ? 0 : 10),
          )),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Row(children: [
          SvgPicture.asset('assets/images/$image'),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: text400normal(
            text: text,
            color: lightblack,
            fontsize: 16,
          )),
          SizedBox(
            width: 32,
            height: 32,
            child: Transform.rotate(
              angle: defaultLang == 'en' ? 3.14159265 : 0,
              child: SvgPicture.asset(
                'assets/images/back.svg',
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _accountTitle(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: text400normal(text: text, color: darkblack, fontsize: 18),
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
          ],
        ),
      ),
    );
  }
}
