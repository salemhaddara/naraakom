// ignore_for_file: must_be_immutable, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';

class profileCard extends StatelessWidget {
  String username, emailAddress, phoneNumber, password;
  profileCard({
    super.key,
    required this.username,
    required this.emailAddress,
    required this.phoneNumber,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Material(
            elevation: 4,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _profilePhotoRow(),
                    _personalDetailsTitle(),
                    Divider(
                      height: 1,
                      color: grey,
                    ),
                    _title('Email'),
                    _value(emailAddress),
                    _title('Phone Number'),
                    _value(phoneNumber),
                    _title('Password'),
                    _value('**************'),
                  ],
                )),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  _value(String text) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      child: text600normal(
        color: darkblack,
        fontsize: 16,
        text: text,
      ),
    );
  }

  _passwordValue(String password) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      child: text600normal(
        color: darkblack,
        fontsize: 16,
        text: password,
      ),
    );
  }

  _title(String text) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: text400normal(
        color: grey,
        fontsize: 16,
        text: text,
      ),
    );
  }

  _personalDetailsTitle() {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          text400normal(
              text: 'Personal Details', color: darkblack, fontsize: 16),
          const Spacer(),
          text600normal(text: 'Edit', fontsize: 16, color: cyan)
        ],
      ),
    );
  }

  _profilePhotoRow() {
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 16),
        height: 80,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(0),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: lightcyan),
                child: SvgPicture.asset(
                  'assets/images/profileCircle.svg',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: text700normal(
                text: username,
                fontsize: 18,
                color: darkblack,
              ),
            ),
          ],
        ));
  }
}
