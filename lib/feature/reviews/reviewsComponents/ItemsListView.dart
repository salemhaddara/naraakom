import 'package:flutter/material.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/ReviewModel.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/feature/reviews/reviewsComponents/reviewItem.dart';

class ItemListView extends StatefulWidget {
  final List<ReviewModel> items;

  const ItemListView({super.key, required this.items});

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  bool showAllItems = false;

  @override
  Widget build(BuildContext context) {
    List<ReviewModel> displayedItems =
        showAllItems ? widget.items : widget.items.take(2).toList();

    return Column(
      children: [
        Column(
          children: List.generate(displayedItems.length,
                  (index) => reviewItem(reviewModel: displayedItems[index]))
              .toList(),
        ),
        if (widget.items.length > 2 && !showAllItems)
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showAllItems = true;
                });
              },
              child: text400normal(
                text: language[defaultLang]['showmore'] ?? 'ShowMore',
                color: grey,
                fontsize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          )
      ],
    );
  }
}
