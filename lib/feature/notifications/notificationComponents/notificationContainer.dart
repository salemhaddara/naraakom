// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/core/utils/Models/NotificationModel.dart';
import 'package:naraakom/feature/notifications/notificationComponents/notificationrichtext.dart';
import '../../../config/theme/colors.dart';
import '../../../core/widgets/text400normal.dart';

// ignore: must_be_immutable
class notificationContainer extends StatefulWidget {
  NotificationModel notification;
  notificationContainer({super.key, required this.notification});

  @override
  State<notificationContainer> createState() => _notificationContainerState();
}

class _notificationContainerState extends State<notificationContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Material(
        elevation: 1,
        shadowColor: lightcyan,
        color: !widget.notification.isRead ? lightcyan : white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: SizedBox(
          height: 100,
          child: Column(children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 72,
                    width: 67,
                    decoration: BoxDecoration(
                        color: lightcyan,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        'assets/images/sample.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: AlignmentDirectional.centerStart,
                            child: notificationrichtext(
                              notificationsender:
                                  widget.notification.senderName,
                              notificationtext:
                                  widget.notification.notificationtext,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/time.svg'),
                              text400normal(
                                  align: TextAlign.start,
                                  text:
                                      ' ${widget.notification.notificationtime}',
                                  fontsize: 12,
                                  color: darkblack),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
