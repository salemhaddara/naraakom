import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/home/homeScreen.dart';
import 'package:naraakom/feature/profile/profileScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../config/theme/colors.dart';

// ignore: must_be_immutable
class MyNavigationBar extends StatefulWidget {
  int index;

  MyNavigationBar({super.key, required this.index});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  late PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const homeScreen(),
      const homeScreen(),
      const homeScreen(),
      const profileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/iconhome.svg'),
        title: language[defaultLang]['home'],
        activeColorPrimary: cyan,
        inactiveColorPrimary: lightblack,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/iconsearch.svg'),
        title: language[defaultLang]['search'],
        activeColorPrimary: cyan,
        inactiveColorPrimary: lightblack,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/iconschedule.svg'),
        title: language[defaultLang]['schedule'],
        activeColorPrimary: cyan,
        inactiveColorPrimary: lightblack,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/iconprofile.svg'),
        title: language[defaultLang]['account'],
        activeColorPrimary: cyan,
        inactiveColorPrimary: lightblack,
      ),
    ];
  }
}
