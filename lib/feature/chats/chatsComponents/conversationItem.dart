// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/Conversation.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/chats/chatScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ConversationItem extends StatelessWidget {
  Function onClick;
  Conversation conversationInfo;
  ConversationItem(
      {super.key, required this.onClick, required this.conversationInfo});
  int messagesNotreaded = 5;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      shadowColor: lightcyan,
      color: white,
      borderRadius: const BorderRadius.all(Radius.circular(13)),
      child: GestureDetector(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ChatScreen(
              conversation: conversationInfo,
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: SizedBox(
          height: 100,
          child: Column(children: [
            SizedBox(
              height: 100,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: AlignmentDirectional.centerStart,
                            child: Row(
                              children: [
                                text600normal(
                                    align: TextAlign.start,
                                    text: conversationInfo.consultant.name,
                                    fontsize: 16,
                                    color: darkblack),
                                const Spacer(),
                                text400normal(
                                    text: '1:00 PM',
                                    color: darkblack,
                                    fontsize: 12)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: AlignmentDirectional.centerStart,
                                child: text400normal(
                                    align: TextAlign.start,
                                    text: conversationInfo.last_message.length >
                                            25
                                        ? ' ${conversationInfo.last_message.substring(0, 25)}...'
                                        : conversationInfo.last_message,
                                    fontsize: 14,
                                    color: darkblack),
                              ),
                              const Spacer(),
                              if (messagesNotreaded != 0)
                                Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsetsDirectional.only(end: 10),
                                  decoration: BoxDecoration(
                                      color: cyan, shape: BoxShape.circle),
                                  child: text400normal(
                                    fontsize: 12,
                                    color: white,
                                    text: '$messagesNotreaded',
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
