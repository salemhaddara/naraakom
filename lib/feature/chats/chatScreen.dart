// ignore_for_file: must_be_immutable, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/Conversation.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/chats/chatsComponents/ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  Conversation conversation;

  ChatScreen({super.key, required this.conversation});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = List.empty(growable: true);
  final TextEditingController _textController = TextEditingController();
  late Size size;
  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text:
          'Embrace the journey, and let the adventure begin.Embrace the journey, and let the adventure begin Embrace the journey, and let the adventure begin',
      isMyMessage: false,
      time: ' ${fromdatetoString(DateTime.now())}',
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Directionality(
        textDirection:
            defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _topbar(size, context, widget.conversation.consultant.name),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                ),
              ),
              const Divider(height: 1.0),
              _buildTextComposer(),
            ],
          ),
        ),
      ),
    );
  }

  _topbar(Size size, BuildContext context, String name) {
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
              text: name,
              fontsize: 20,
              color: lightblack,
            ),
          )
        ]),
      ),
    );
  }

  String fromdatetoString(DateTime time) {
    DateTime now = time;
    String formattedTime = now.hour > 12
        ? '${now.hour - 12}:${now.minute} PM'
        : '${now.hour}:${now.minute} AM';
    String formattedDate = now.day == DateTime.now().day
        ? 'Today'
        : '${now.day}/${now.month}/${now.year}';
    return '$formattedDate $formattedTime';
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      isMyMessage: true, // My message
      time: fromdatetoString(DateTime.now()),
    );
    if (message.text.isNotEmpty) {
      setState(() {
        _messages.insert(0, message);
      });
    }
  }
}
