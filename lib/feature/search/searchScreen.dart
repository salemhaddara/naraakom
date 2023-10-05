import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/utils/Models/ConsultantModel.dart';
import '../../core/widgets/responsiveconsultant.dart';
import '../../core/widgets/searchbar.dart';
import '../../core/widgets/text400normal.dart';
import '../../core/widgets/text600normal.dart';
import '../../core/widgets/text700normal.dart';
import '../consultantinfo.dart/consultantinfo.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
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
        child: Column(
          children: [
            _buildHomeTopBar(size),
            _searchWidget(size),
            _categorieslist(size),
            _searchConsultantsquantity(size),
            _consultantsList(),
          ],
        ),
      ),
    );
  }

  Widget _searchConsultantsquantity(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(16),
      child: text700normal(
          text: '200+ Consultants', fontsize: 20, color: darkblack),
    );
  }

  Widget _categorieslist(Size size) {
    return Container(
        margin: const EdgeInsetsDirectional.only(start: 8),
        height: 70,
        width: size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _categoryItem('All', 'categoryall.svg', true),
            _categoryItem(language[defaultLang]['familyconsultant'],
                'familyconsultingicon.svg', false),
            _categoryItem(language[defaultLang]['educationnalconsultant'],
                'educationnalconsultanticon.svg', false),
            _categoryItem(language[defaultLang]['psychologicalconsultant'],
                'psychologicalconsultanticon.svg', false),
            _categoryItem(language[defaultLang]['professionalconsultant'],
                'professionalconsultanticon.svg', false),
            _categoryItem(language[defaultLang]['humandevelopment'],
                'humandevelopmenticon.svg', false),
            _categoryItem(language[defaultLang]['behaviorconsultant'],
                'behaviorconsultanticon.svg', false),
          ],
        ));
  }

  Widget _categoryItem(String categoryName, String image, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
          color: isSelected ? lightcyan : homebackgrey,
          border: Border.all(color: cyan, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(13))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/$image'),
          const SizedBox(
            width: 5,
          ),
          text600normal(
              text: categoryName,
              fontsize: 16,
              color: isSelected ? darkblack : darkblack)
        ],
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
                    consultation_rate: 250,
                    visitors: 1000,
                    experience: 7,
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
                          specializations: [],
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
            Container(
              margin:
                  EdgeInsets.only(top: size.height * 0.08, left: 16, right: 16),
              child: text700normal(
                  text: 'Desired Consultation', fontsize: 22, color: white),
            )
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
