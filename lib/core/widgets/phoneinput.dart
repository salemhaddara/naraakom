import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';

import 'inputFormater.dart';

// ignore: camel_case_types, must_be_immutable
class phoneinput extends StatefulWidget {
  Function(PhoneNumber) onChanged;
  Color? color;
  phoneinput({super.key, required this.onChanged, this.color});

  @override
  State<phoneinput> createState() => _phoneinputState();
}

class _phoneinputState extends State<phoneinput> {
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
              color: widget.color ?? lightcyan,
              borderRadius: const BorderRadius.all(Radius.circular(13))),
        ),
        IntlPhoneField(
          textAlign: defaultLang == 'ar' ? TextAlign.right : TextAlign.left,
          keyboardType: TextInputType.number,
          inputFormatters: [NumericTextInputFormatter()],
          onChanged: (text) {
            setState(() {
              if (!isEnabled) isEnabled = true;
            });

            widget.onChanged(text);
          },
          languageCode: defaultLang,
          pickerDialogStyle: PickerDialogStyle(
              countryCodeStyle: GoogleFonts.nunitoSans(
                  color: darkblack, fontWeight: FontWeight.w500),
              countryNameStyle: GoogleFonts.nunitoSans(
                  color: darkblack, fontWeight: FontWeight.w500)),
          decoration: const InputDecoration(
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                borderSide: BorderSide(color: Colors.red)),
          ),
          initialCountryCode: 'QA',
          disableLengthCheck: true,
          cursorColor: cyan,
          autovalidateMode: isEnabled
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w400, fontSize: 14, color: lightblack),
          validator: (text) {
            try {
              text!.isValidNumber();
              return null;
            } catch (e) {
              if (e is NumberTooShortException) {
                if (text!.number.isEmpty) {
                  return '';
                } else {
                  return language[defaultLang]['numbertooshort'];
                }
              } else if (e is NumberTooLongException) {
                return language[defaultLang]['numbertoolong'];
              } else {
                return language[defaultLang]['enteravalidphone'];
              }
            }
          },
        ),
      ],
    );
  }
}
