import 'package:flutter/material.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMyMessage;
  final String time;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isMyMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMyMessage)
                Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        'assets/images/sample.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    constraints: const BoxConstraints(maxWidth: 290),
                    decoration: BoxDecoration(
                      color: isMyMessage ? cyan : lightcyan,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: text400normal(
                      text: text,
                      color: isMyMessage ? white : lightblack,
                      fontsize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(children: [
                      text400normal(
                        text: time,
                        color: grey,
                        fontsize: 12,
                      ),
                    ]),
                  ),
                ],
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 4.0),
          //   child: Row(children: [
          //     text400normal(
          //       text: time,
          //       color: grey,
          //       fontsize: 12,
          //     ),
          //   ]),
          // ),
        ],
      ),
    );
  }
}
