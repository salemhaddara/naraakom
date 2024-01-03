// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/inputfield.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/splash/splash.dart';

class schemaCase extends StatelessWidget {
  Function(String) ageChanged;
  Function(String) caseDescriptionChanged;
  Function onSubmit;
  Function onCancel;
  schemaCase(
      {super.key,
      required this.ageChanged,
      required this.caseDescriptionChanged,
      required this.onSubmit,
      required this.onCancel});
  String ageCheck = '', caseDescriptionCheck = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(16),
      child: Form(
          child: Column(
        children: [
          _notice(size),
          _schemaCaseAgeTitle(size),
          _schemaCaseAgeInputField(size),
          _schemaCaseDescriptionTitle(size),
          _schemaCaseInputField(size),
          _schemaCaseContinueButton(size),
          _schemaCaseCancelButton(size, context)
        ],
      )),
    );
  }

  _notice(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: text400normal(
          text: language[defaultLang]['additionalinformation'],
          color: grey,
          fontsize: 14),
    );
  }

  _schemaCaseAgeTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['age'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  _schemaCaseAgeInputField(Size size) {
    return InputField(
      hint: '',
      isPassword: false,
      validator: (age) {
        if (age!.isEmpty) {
          return null;
        }

        return null;
      },
      initialState: false,
      onChanged: (text) {
        ageChanged(text ?? '');
        ageCheck = text ?? '';
      },
    );
  }

  _schemaCaseDescriptionTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['case'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  _schemaCaseInputField(Size size) {
    return InputField(
      hint: '',
      isPassword: false,
      height: 108,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }

        return null;
      },
      initialState: false,
      onChanged: (text) {
        caseDescriptionChanged(text ?? '');
        caseDescriptionCheck = text ?? '';
      },
    );
  }

  _schemaCaseContinueButton(Size size) {
    return Container(
        margin: const EdgeInsets.only(top: 25, bottom: 16),
        child: button(
            text: language[defaultLang]['proceedtopayment'],
            width: size.width,
            onTap: () {
              if (ageCheck.isNotEmpty && caseDescriptionCheck.isNotEmpty) {
                onSubmit();
                // context
                //     .read<bookingAppointmentbloc>()
                //     .add(bookingSchemaIndexChanged());
                // context.read<bookingAppointmentbloc>().add(submitCaseInfo(
                //       age: ageCheck,
                //       caseDescription: caseDescriptionCheck,
                //     ));
              }
            }));
  }

  _schemaCaseCancelButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCancel();
        // context
        //     .read<bookingAppointmentbloc>()
        //     .add(bookingSchemaCancelInvoked());
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: text600normal(
              text: language[defaultLang]['cancel'],
              color: cyan,
              fontsize: 16)),
    );
  }
}
