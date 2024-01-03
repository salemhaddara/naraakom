import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/inputfield.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/feature/splash/splash.dart';

class PaymentMethodForm extends StatelessWidget {
  final String paymentMethod;
  final VoidCallback onCancel;

  const PaymentMethodForm(
      {super.key, required this.paymentMethod, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text400normal(
              text: language[defaultLang]['cardnumber'],
              color: darkblack,
              fontsize: 14),
          const SizedBox(height: 16),
          InputField(
            hint: '1234 5678 9101 1121',
            isPassword: false,
            initialState: false,
            validator: (text) {
              return null;
            },
            onChanged: (text) {},
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.bottomStart,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: text400normal(
                          text: 'MM/YYYY', color: darkblack, fontsize: 14),
                    ),
                    InputField(
                        isPassword: false,
                        hint: '00/000',
                        initialState: false,
                        validator: (validator) {
                          return null;
                        },
                        onChanged: (onChanged) {})
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.bottomStart,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: text400normal(
                          text: 'CCV', color: darkblack, fontsize: 14),
                    ),
                    InputField(
                        isPassword: false,
                        hint: '000',
                        initialState: false,
                        validator: (validator) {
                          return null;
                        },
                        onChanged: (onChanged) {})
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: AlignmentDirectional.bottomStart,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: text400normal(
                text: language[defaultLang]['cardholdername'],
                color: darkblack,
                fontsize: 14),
          ),
          InputField(
            hint: '',
            isPassword: false,
            initialState: false,
            validator: (text) {
              return null;
            },
            onChanged: (text) {},
          ),
          const SizedBox(height: 16),
          button(
              text: language[defaultLang]['addnewcard'],
              width: MediaQuery.of(context).size.width,
              onTap: () {}),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
