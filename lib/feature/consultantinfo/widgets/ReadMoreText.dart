// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:naraakom/feature/signup/signupcomponents/siginrichtext.dart';

class ReadMoreText extends StatefulWidget {
  final String text;

  const ReadMoreText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.text;

    return Column(
      children: [
        AnimatedCrossFade(
          firstChild: Column(
            children: [
              signinrichtext(
                startText: isExpanded
                    ? text
                    : (text.length > 180 ? text.substring(0, 180) : text),
                clickableText: (text.length > 180) ? ' Read More' : '',
                onClick: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ],
          ),
          secondChild: Column(
            children: [
              signinrichtext(
                startText: text,
                clickableText: (text.length > 180) ? ' Read Less' : '',
                onClick: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ],
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
