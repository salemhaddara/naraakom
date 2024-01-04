// ignore_for_file: camel_case_types,file_names, must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/inputfield.dart';
import 'package:naraakom/core/widgets/phoneinput.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/splash/splash.dart';

class contactInfo extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Size size;
  Function(String) onEmailChanged;
  Function(String) onPhoneNumberChanged;
  Function(String) onCompletePhoneNumberChanged;
  Function(String) onNameChanged;
  Function(bool) onContinueClicked;
  Function() onCancelClicked;
  contactInfo({
    super.key,
    required this.formKey,
    required this.onEmailChanged,
    required this.size,
    required this.onPhoneNumberChanged,
    required this.onCompletePhoneNumberChanged,
    required this.onNameChanged,
    required this.onContinueClicked,
    required this.onCancelClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Form(
          key: formKey,
          child: Column(
            children: [
              _schemacontactInfonameTitle(size),
              _schemacontactInfonameField(size),
              _schemacontactInfoemailTitle(size),
              _schemacontactInfoemailInputField(size),
              _schemacontactInfophoneNumberTitle(size),
              _schemacontactInfophoneInputField(size),
              __schemacontactInfoContinueButton(size, context),
              __schemacontactInfoCancelButton(size, context)
            ],
          )),
    );
  }

  _schemacontactInfoemailInputField(Size size) {
    return InputField(
      hint: '',
      color: homebackgrey,
      isPassword: false,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }
        if (!isValidEmail(email)) {
          return language[defaultLang]['enteravalidemail'];
        }
        return null;
      },
      initialState: false,
      onChanged: (text) {
        onEmailChanged('$text');
      },
    );
  }

  bool isValidEmail(String email) {
    RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  _schemacontactInfoemailTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['email'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  __schemacontactInfoContinueButton(Size size, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25, bottom: 16),
        child: button(
            text: language[defaultLang]['continue'],
            width: size.width,
            onTap: () {
              onContinueClicked(formKey.currentState!.validate());
            }));
  }

  __schemacontactInfoCancelButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCancelClicked();
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: text600normal(
              text: language[defaultLang]['cancel'],
              color: cyan,
              fontsize: 16)),
    );
  }

  _schemacontactInfophoneNumberTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 26, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['phonenumber'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  _schemacontactInfophoneInputField(Size size) {
    return phoneinput(
      color: homebackgrey,
      onChanged: (text) {
        onPhoneNumberChanged(text.number);
        onCompletePhoneNumberChanged(text.completeNumber);
      },
    );
  }

  _schemacontactInfonameTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['name'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  _schemacontactInfonameField(Size size) {
    return InputField(
      hint: '',
      isPassword: false,
      color: homebackgrey,
      validator: (name) {
        if (name!.isEmpty) {
          return null;
        }
        if (name.length < 3) {
          return language[defaultLang]['namerror'];
        }
        return null;
      },
      initialState: false,
      onChanged: (text) {
        onNameChanged('$text');
      },
    );
  }
}
