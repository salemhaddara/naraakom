import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naraakom/config/theme/colors.dart';

class signinrichtext extends StatelessWidget {
  final String startText;
  final String clickableText;
  final VoidCallback onClick;

  const signinrichtext({
    super.key,
    required this.startText,
    required this.clickableText,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: startText,
            style: GoogleFonts.nunito(
                color: grey, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          TextSpan(
            text: clickableText,
            style: GoogleFonts.nunito(
                color: cyan, fontWeight: FontWeight.w400, fontSize: 16),
            recognizer: TapGestureRecognizer()..onTap = onClick,
          ),
        ],
      ),
    );
  }
}
