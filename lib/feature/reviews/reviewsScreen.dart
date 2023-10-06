import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text600normal.dart';

class reviewsScreen extends StatefulWidget {
  const reviewsScreen({super.key});

  @override
  State<reviewsScreen> createState() => _reviewsScreenState();
}

class _reviewsScreenState extends State<reviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.all(Radius.circular(14))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: cyan,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14))),
            child: Row(children: [
              text600normal(
                  text: language[defaultLang]['reviews'],
                  fontsize: 16,
                  color: white),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset('assets/images/exit.svg'))
            ]),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Row(
              children: [],
            ),
          ),
          const Divider(),
        ],
      ),
    ),
  );
}
