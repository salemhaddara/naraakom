import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/core/utils/Models/NotificationModel.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/notifications/notificationComponents/notificationContainer.dart';

import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';

// ignore: camel_case_types
class notificationScreen extends StatefulWidget {
  const notificationScreen({super.key});

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

// ignore: camel_case_types
class _notificationScreenState extends State<notificationScreen> {
  List notifications = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
        backgroundColor: white,
        body: Directionality(
          textDirection:
              defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(
              top: size.height * .05,
            ),
            child: Column(children: [
              _topbar(size),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _todaybar(size);
                      }
                      if (index == 3) {
                        return _earlierbar(size);
                      }
                      return notificationContainer(
                        notification: NotificationModel(
                            senderName: 'Salem Haddara',
                            notificationtext: 'accepted your appointment',
                            notificationtime: '4:07 PM',
                            senderprofileURL: '',
                            isRead: false),
                      );
                    }),
              )
            ]),
          ),
        ));
  }

  _earlierbar(Size size) {
    return Container(
      height: 30,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          text400normal(
              text: language[defaultLang]['earlier'],
              color: lightblack,
              fontsize: 16),
          Expanded(child: Container()),
          text400normal(
            text: language[defaultLang]['markallasread'],
            color: darkblack,
            fontsize: 16,
          )
        ],
      ),
    );
  }

  _todaybar(Size size) {
    return Container(
      height: 30,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          text400normal(
              text: language[defaultLang]['today'],
              color: lightblack,
              fontsize: 16),
          Expanded(child: Container()),
          text400normal(
            text: language[defaultLang]['markallasread'],
            color: darkblack,
            fontsize: 16,
          )
        ],
      ),
    );
  }

  _topbar(Size size) {
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
              Navigator.of(context).pop();
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
              text: language[defaultLang]['notifications'],
              fontsize: 20,
              color: lightblack,
            ),
          )
        ]),
      ),
    );
  }
}
