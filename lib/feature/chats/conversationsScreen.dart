import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/Conversation.dart';
import 'package:naraakom/core/utils/Models/Message.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/chats/chatsComponents/conversationItem.dart';

class conversationsScreen extends StatefulWidget {
  const conversationsScreen({super.key});

  @override
  State<conversationsScreen> createState() => _conversationsScreenState();
}

class _conversationsScreenState extends State<conversationsScreen> {
  List<Conversation> conversations = List.empty(growable: true);
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
                  _topbar(size, context),
                  const SizedBox(
                    height: 2,
                  ),
                  Expanded(
                      child:
                          //CHECK HERE IF THERE NOTIFICATIONS TODAY OR EARLIER
                          ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 1,
                              padding: const EdgeInsets.only(top: 0),
                              itemBuilder: (context, index) {
                                return ConversationItem(
                                  onClick: () {},
                                  conversationInfo: Conversation(
                                      last_message:
                                          'Embrace the journey, and let the adventure begin',
                                      consultant: ConsultantModel(
                                          name: 'Salem Haddara',
                                          category: 'Family Consulting',
                                          availability: '8 AM to 10 PM',
                                          rating: 5,
                                          id: 'id4',
                                          experience: 2,
                                          consultation_rate: 250,
                                          visitors: 1000,
                                          biography: 'later',
                                          specializations: [],
                                          bookedTimes: []),
                                      UserId: 'UserId',
                                      lastUse: DateTime.now(),
                                      messages: [
                                        Message(
                                            messagetext: '',
                                            messagesenderId: 'messagesenderId',
                                            messagereceiverId:
                                                'messagereceiverId',
                                            messageTime: DateTime.now(),
                                            isReaded: true)
                                      ]),
                                );
                              }))
                ]))));
  }
}

_topbar(Size size, BuildContext context) {
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: text600normal(
            text: language[defaultLang]['chats'] ?? 'Chats',
            fontsize: 20,
            color: lightblack,
          ),
        ),
        const Spacer(),
        // InkWell(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   borderRadius: const BorderRadius.all(Radius.circular(8)),
        //   child: Container(
        //     width: 32,
        //     height: 32,
        //     decoration: const BoxDecoration(
        //         borderRadius: BorderRadius.all(Radius.circular(8))),
        //     child: SvgPicture.asset(
        //       'assets/images/iconsearch.svg',
        //     ),
        //   ),
        // ),
      ]),
    ),
  );
}
