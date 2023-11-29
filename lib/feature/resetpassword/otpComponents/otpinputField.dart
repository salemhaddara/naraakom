import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naraakom/config/theme/colors.dart';

class OtpInputFields extends StatefulWidget {
  final Function(String) onOtpComplete;
  final Function(String) onChange; // Added onChange parameter
  final bool isError; // Added isError parameter

  const OtpInputFields(
      {super.key,
      required this.onOtpComplete,
      required this.onChange,
      this.isError = false});

  @override
  _OtpInputFieldsState createState() => _OtpInputFieldsState();
}

class _OtpInputFieldsState extends State<OtpInputFields> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var i = 0; i < 6; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    super.dispose();
  }

  void _checkOtpComplete() {
    final otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      widget.onOtpComplete(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 46,
          height: 47,
          margin: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: lightcyan,
            border: Border.all(
              color: widget.isError ? Colors.red : lightcyan,
              width: 2, // Conditional border color
            ),
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              widget.onChange(value); // Call onChange callback
              if (value.isNotEmpty) {
                _focusNodes[index].nextFocus();
                _checkOtpComplete();
              }
            },
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            style: GoogleFonts.nunitoSans(fontSize: 22),
          ),
        );
      }),
    );
  }
}
