import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naraakom/config/theme/colors.dart';

class notificationrichtext extends StatelessWidget {
  final String notificationsender;
  final String notificationtext;

  const notificationrichtext({
    super.key,
    required this.notificationsender,
    required this.notificationtext,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: notificationsender,
            style: GoogleFonts.nunito(
              color: lightblack,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: ' $notificationtext',
            style: GoogleFonts.nunito(
                color: grey, fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
