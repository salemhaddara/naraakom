import 'package:flutter/material.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';

// ignore: camel_case_types, must_be_immutable
class acceptterms extends StatefulWidget {
  Function(bool) onChangedState;
  acceptterms({super.key, required this.onChangedState});

  @override
  accepttermsState createState() => accepttermsState();
}

class accepttermsState extends State<acceptterms> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            focusColor: cyan,
            activeColor: cyan,
            onChanged: (newValue) {
              widget.onChangedState(newValue ?? false);
              setState(() {
                isChecked = newValue ?? false;
              });
            },
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: language[defaultLang]['iagreetothe'],
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: language[defaultLang]['termsandconditions'],
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: cyan,
                        fontSize: 14),
                  ),
                  TextSpan(
                      text: ' ${language[defaultLang]['and']} ',
                      style: const TextStyle(fontSize: 14)),
                  TextSpan(
                    text: language[defaultLang]['privacypolicy'],
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: cyan,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
