// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/core/widgets/responsiveconsultant.dart';
import 'package:naraakom/core/widgets/searchbar.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/consultantinfo.dart/consultantinfo.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/utils/Models/ConsultantModel.dart';
import '../../core/widgets/text700normal.dart';

class categoryViewer extends StatefulWidget {
  String category;
  categoryViewer({super.key, required this.category});

  @override
  State<categoryViewer> createState() => _categoryViewerState();
}

class _categoryViewerState extends State<categoryViewer> {
  String? selectedFilter; // Store the selected value here

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: homebackgrey,
      body: Directionality(
        textDirection:
            defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: cyan,
                expandedHeight: size.height * 0.08,
                centerTitle: false,
                title: text700normal(
                  text: widget.category,
                  color: white,
                  fontsize: 22,
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: SizedBox(),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHomeTopBar(size),
                ),
              ),
            ];
          },
          body: Column(
            children: [_searchWidget(size), _consultantsList()],
          ),
        ),
      ),
    );
  }

  Widget _consultantsList() {
    return Expanded(
        child: ListView.builder(
            itemCount: 2,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return responiveconsultant(
                islarge: true,
                consultant: ConsultantModel(
                    name: 'Salem Haddara',
                    category: 'Family Consulting',
                    availability: '8 AM to 10 PM',
                    rating: 5,
                    id: 'id4',
                    experience: 2,
                    consultation_rate: 250,
                    visitors: 1000,
                    biography: 'later',
                    specializations: [],
                    bookings: []),
                onClick: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: consultantinfo(
                      consultant: ConsultantModel(
                          name: 'Salem Haddara',
                          category: 'Family Consulting',
                          availability: '8 AM to 10 PM',
                          rating: 5,
                          id: 'id4',
                          experience: 2,
                          consultation_rate: 250,
                          visitors: 1000,
                          biography: 'later',
                          specializations: [
                            'Family Consultant',
                            'Human Development',
                            'Behavior Modification'
                          ],
                          bookings: []),
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              );
            }));
  }

  Widget _searchWidget(Size size) {
    return Row(children: [
      searchbar(hint: 'Search by consultant name', onChanged: (onChanged) {}),
      Container(
        height: 34,
        width: 34,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsetsDirectional.only(end: 20),
        child: GestureDetector(
          onTap: () {
            _showSorting(size);
          },
          child: SvgPicture.asset(
            'assets/images/iconfilter.svg',
          ),
        ),
      )
    ]);
  }

  Widget _buildHomeTopBar(Size size) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      width: size.width,
      height: size.height * 0.15,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bar.png',
              width: size.width,
              height: size.height * 0.20,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  _showSorting(Size size) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: cyan,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14),
                      topLeft: Radius.circular(14))),
              child: Row(children: [
                Expanded(
                  child: text400normal(
                    text: 'Filter by',
                    color: white,
                    fontsize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedFilter = '';
                    Navigator.pop(context);
                  },
                  child: text600normal(
                    text: 'Clear',
                    color: white,
                    fontsize: 14,
                  ),
                ),
              ]),
            ),
            ListTile(
              title: text400normal(
                text: 'Highest Rating',
                color: darkblack,
                fontsize: 14,
              ),
              leading: Radio(
                value: 'Highest Rating',
                groupValue: selectedFilter,
                activeColor: cyan,
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value;
                  });
                },
              ),
            ),
            ListTile(
              title: text400normal(
                text: 'Lowest Price',
                color: darkblack,
                fontsize: 14,
              ),
              leading: Radio(
                value: 'Lowest Price',
                groupValue: selectedFilter,
                activeColor: cyan,
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value;
                  });
                },
              ),
            ),
            ListTile(
              title: text400normal(
                text: 'Highest Price',
                color: darkblack,
                fontsize: 14,
              ),
              leading: Radio(
                value: 'Highest Price',
                groupValue: selectedFilter,
                activeColor: cyan,
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
