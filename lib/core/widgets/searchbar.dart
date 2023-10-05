import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/colors.dart';

class searchbar extends StatelessWidget {
  final String hint;
  final Function(String?) onChanged;
  const searchbar({
    Key? key,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 54,
        child: TextFormField(
          onChanged: (text) {
            onChanged(text);
          },
          cursorColor: cyan,
          style: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: lightblack),
          decoration: InputDecoration(
              fillColor: white,
              filled: true,
              prefixIcon: Container(
                  height: 16,
                  width: 16,
                  margin: const EdgeInsets.all(10),
                  child: Opacity(
                      opacity: 0.4,
                      child: SvgPicture.asset('assets/images/iconsearch.svg'))),
              hintText: hint,
              contentPadding: const EdgeInsets.all(15),
              hintStyle: GoogleFonts.nunitoSans(
                  color: grey, fontWeight: FontWeight.w400, fontSize: 16),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide(color: cyan, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide(color: cyan, width: 1))),
        ),
      ),
    );
  }
}
