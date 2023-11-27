// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:naraakom/config/theme/colors.dart';
import '../../../core/utils/Models/ReviewModel.dart';
import '../../../core/widgets/text400normal.dart';

class reviewItem extends StatelessWidget {
  ReviewModel reviewModel;
  reviewItem({super.key, required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.all(Radius.circular(14))),
      margin: const EdgeInsets.all(16),
      child: Material(
        elevation: 4,
        color: white,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints(maxWidth: 350),
                child: text400normal(
                  text: reviewModel.user.name,
                  color: darkblack,
                  fontsize: 16,
                ),
              ),
              Container(
                height: 60,
                constraints: const BoxConstraints(maxWidth: 350),
                child: text400normal(
                  text: reviewModel.reviewText,
                  color: grey,
                  fontsize: 16,
                ),
              ),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    RatingBar.builder(
                      initialRating: reviewModel.ratingRate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 18,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      ignoreGestures: true,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    text400normal(
                        text: formatDateTime(reviewModel.reviewDateTime),
                        color: grey,
                        fontsize: 14)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(dateTime);
  }
}
