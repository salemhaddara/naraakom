// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/reviews/reviewsComponents/ItemsListView.dart';
import 'package:percent_indicator/percent_indicator.dart';

class reviewsScreen extends StatefulWidget {
  ConsultantModel consultantinfo;
  reviewsScreen({super.key, required this.consultantinfo});

  @override
  State<reviewsScreen> createState() => _reviewsScreenState();
}

class _reviewsScreenState extends State<reviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.all(Radius.circular(14))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _reviewsTopBar(),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: lightcyan,
                    borderRadius: const BorderRadius.all(Radius.circular(14))),
                child: Material(
                  elevation: 2,
                  color: lightcyan,
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _ratingtitle(),
                        _ratingandratingbar(),
                        _reviewsnumber()
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              _ratingwithlinearbar(
                  language[defaultLang]['consultantrating'], 0.8),
              _ratingwithlinearbar(language[defaultLang]['overallrating'], 0.9),
              ItemListView(items: widget.consultantinfo.reviews!),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  _ratingwithlinearbar(String title, double currenrate) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
              child:
                  text600normal(text: title, fontsize: 16, color: darkblack)),
          Expanded(
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 10.0,
              animationDuration: 2000,
              percent: currenrate,
              barRadius: const Radius.circular(13),
              progressColor: cyan,
            ),
          )
        ],
      ),
    );
  }

  _reviewsnumber() {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          text400normal(
              text:
                  '${language[defaultLang]['basedon']} ${(widget.consultantinfo.reviews?.length) ?? '0'}',
              color: grey,
              fontsize: 14),
          const Spacer()
        ],
      ),
    );
  }

  _ratingandratingbar() {
    return SizedBox(
      height: 75,
      child: Row(
        children: [
          text700normal(
            text: '${widget.consultantinfo.rating}',
            color: darkblack,
            fontsize: 40,
            align: TextAlign.start,
          ),
          Container(
            height: 20,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 5),
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 25,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              ignoreGestures: true,
              onRatingUpdate: (rating) {},
            ),
          )
        ],
      ),
    );
  }

  _ratingtitle() {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          text400normal(
            text: language[defaultLang]['overallrating'],
            color: grey,
            fontsize: 16,
            align: TextAlign.start,
          ),
          const Spacer()
        ],
      ),
    );
  }

  _reviewsTopBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: cyan,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      child: Row(children: [
        text600normal(
            text: language[defaultLang]['reviews'], fontsize: 16, color: white),
        const Spacer(),
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset('assets/images/exit.svg'))
      ]),
    );
  }
}
