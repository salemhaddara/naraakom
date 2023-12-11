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
        color: widget.notification.read == 0 ? lightcyan : white,
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
                              notificationsender: widget.notification.title,
                              notificationtext: widget.notification.content,
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
                                  text: formatDateTime(
                                      widget.notification.created),
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

  String formatDateTime(String dateTimeString) {
    DateTime parsedDate = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();

    if (parsedDate.year == now.year &&
        parsedDate.month == now.month &&
        parsedDate.day == now.day) {
      String period = parsedDate.hour >= 12 ? 'PM' : 'AM';
      int hour = parsedDate.hour > 12 ? parsedDate.hour - 12 : parsedDate.hour;
      if (hour == 0) {
        hour = 12;
      }
      String formattedTime =
          '$hour:${parsedDate.minute.toString().padLeft(2, '0')} $period';
      return 'Today $formattedTime';
    } else {
      String formattedDate =
          '${parsedDate.year}-${parsedDate.month}-${parsedDate.day}';
      String period = parsedDate.hour >= 12 ? 'PM' : 'AM';
      int hour = parsedDate.hour > 12 ? parsedDate.hour - 12 : parsedDate.hour;
      if (hour == 0) {
        hour = 12;
      }
      String formattedTime =
          '$hour:${parsedDate.minute.toString().padLeft(2, '0')} $period';
      return '$formattedDate $formattedTime';
    }
  }
}
