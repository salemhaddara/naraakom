import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:naraakom/config/theme/colors.dart';

import 'inputFormater.dart';

// ignore: camel_case_types, must_be_immutable
class phoneinput extends StatefulWidget {
  Function(PhoneNumber) onChanged;
  phoneinput({super.key, required this.onChanged});

  @override
  State<phoneinput> createState() => _phoneinputState();
}

class _phoneinputState extends State<phoneinput> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
              color: lightcyan,
              borderRadius: const BorderRadius.all(Radius.circular(13))),
        ),
        IntlPhoneField(
          keyboardType: TextInputType.number,
          inputFormatters: [NumericTextInputFormatter()],
          onChanged: (text) {
            widget.onChanged(text);
          },
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
          disableLengthCheck: false,
          cursorColor: cyan,
          autovalidateMode: AutovalidateMode.always,
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
                  return 'Number too Short ';
                }
              } else if (e is NumberTooLongException) {
                return 'Number too long';
              } else {
                return 'Enter A Valid Phone Number ';
              }
            }
          },
        ),
      ],
    );
  }
}
