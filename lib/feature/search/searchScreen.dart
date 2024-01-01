// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/feature/home/Repository/repository.dart';
import 'package:naraakom/feature/home/states/contentbloc.dart';
import 'package:naraakom/feature/home/states/contentevent.dart';
import 'package:naraakom/feature/home/states/contentstate.dart';
import 'package:naraakom/feature/home/tracker/consultantsrequeststate.dart';
import 'package:naraakom/feature/search/searchComponents/CategoriesList.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/utils/Models/ConsultantModel.dart';
import '../../core/widgets/responsiveconsultant.dart';
import '../../core/widgets/searchbar.dart';
import '../../core/widgets/text400normal.dart';
import '../../core/widgets/text600normal.dart';
import '../../core/widgets/text700normal.dart';
import '../consultantinfo/consultantinfo.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

enum ConsultantSortFilter {
  HighestRating,
  LowestPrice,
  HighestPrice,
}

int HIGHEST_PRICE = 1;
int HIGHEST_RATE = 2;
int LOWEST_PRICE = 3;

class _searchScreenState extends State<searchScreen> {
  int selectedFilter = 0;
  String selectedCategory = 'all';
  List<ConsultantModel>? filteredList;
  List<ConsultantModel> helper = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: homebackgrey,
      body: Directionality(
        textDirection:
            defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: BlocProvider<contentbloc>(
          create: (context) {
            return contentbloc(context.read<Repository>())
              ..add(ConsultantsRequested());
          },
          child: Column(
            children: [
              _buildHomeTopBar(size),
              _searchWidget(size),
              _categorieslist(size),
              _searchConsultantsquantity(size),
              // _consultantsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchConsultantsquantity(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(16),
      child: text700normal(
          text: language[defaultLang]['consultants'],
          fontsize: 20,
          color: darkblack),
    );
  }

  Widget _categorieslist(
    Size size,
  ) {
    return BlocBuilder<contentbloc, contentstate>(builder: (context, state) {
      return CategoriesList(
        onCategorySelected: (category) {
          context.read<contentbloc>().add(SelectCategoryEvent(category));
        },
      );
    });
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

  // Widget _consultantsList() {
  //   return BlocBuilder<contentbloc, contentstate>(builder: (context, state) {
  //     if (state.requeststate is consultantsrequest_SUCCESS) {
  //       context.read<contentbloc>().add(SelectCategoryEvent(selectedCategory));
  //     }
  //     if (state.requeststate is CategorySelectedState) {
  //       filteredList = sortConsultants(
  //           ((state.requeststate) as CategorySelectedState).filteredList,
  //           selectedFilter);

  //       return _returnListView(filteredList!);
  //     }
  //     if (state.requeststate is SearchState) {
  //       filteredList = sortConsultants(
  //           ((state.requeststate) as SearchState).searchedconsultants,
  //           selectedFilter);
  //       return _returnListView(filteredList!);
  //     }
  //     return Container();
  //   });
  // }

  Widget _returnListView(List<ConsultantModel> consutants) {
    return Expanded(
        child: ListView.builder(
            itemCount: consutants.length,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return responiveconsultant(
                islarge: true,
                consultant: consutants[index],
                onClick: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: consultantinfo(
                      consultant: consutants[index],
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              );
            }));
  }

  Widget _searchWidget(Size size) {
    return BlocBuilder<contentbloc, contentstate>(
      builder: (context, state) {
        if (state.requeststate is SearchState) {
          filteredList =
              ((state.requeststate) as SearchState).searchedconsultants;
        }
        return Row(children: [
          searchbar(
              hint: language[defaultLang]['searchbyconsultantname'],
              onChanged: (onChanged) {
                context
                    .read<contentbloc>()
                    .add(SearchtextChangedEvent(onChanged, selectedCategory));
              }),
          Container(
            height: 34,
            width: 34,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsetsDirectional.only(end: 20),
            child: GestureDetector(
              onTap: () async {
                await _showSorting(size);
                context.read<contentbloc>().add(ConsultantsRequested());
              },
              child: SvgPicture.asset(
                'assets/images/iconfilter.svg',
              ),
            ),
          )
        ]);
      },
    );
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
                  text: language[defaultLang]['desiredconsultation'],
                  fontsize: 22,
                  color: white),
            )
          ],
        ),
      ),
    );
  }

  _showSorting(Size size) async {
    return await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Directionality(
          textDirection:
              defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: cyan,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(14),
                        topLeft: Radius.circular(14))),
                child: Row(children: [
                  Expanded(
                    child: text400normal(
                      text: language[defaultLang]['filterby'],
                      color: white,
                      fontsize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedFilter;
                      Navigator.pop(context);
                    },
                    child: text600normal(
                      text: language[defaultLang]['clear'],
                      color: white,
                      fontsize: 14,
                    ),
                  ),
                ]),
              ),
              ListTile(
                title: text400normal(
                  text: language[defaultLang]['highestrating'],
                  color: darkblack,
                  fontsize: 14,
                ),
                leading: Radio(
                  value: HIGHEST_RATE,
                  groupValue: selectedFilter,
                  activeColor: cyan,
                  onChanged: (value) {
                    selectedFilter = value!;
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: text400normal(
                  text: language[defaultLang]['lowestprice'],
                  color: darkblack,
                  fontsize: 14,
                ),
                leading: Radio(
                  value: LOWEST_PRICE,
                  groupValue: selectedFilter,
                  activeColor: cyan,
                  onChanged: (value) {
                    selectedFilter = value!;
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: text400normal(
                  text: language[defaultLang]['highestprice'],
                  color: darkblack,
                  fontsize: 14,
                ),
                leading: Radio(
                  value: HIGHEST_PRICE,
                  groupValue: selectedFilter,
                  activeColor: cyan,
                  onChanged: (value) {
                    selectedFilter = value!;
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }

  // List<ConsultantModel> sortConsultants(
  //   List<ConsultantModel> consultants,
  //   int filter,
  // ) {
  //   switch (filter) {
  //     case 2:
  //       consultants.sort((a, b) => b.rating.compareTo(a.rating));
  //       break;
  //     case 3:
  //       consultants
  //           .sort((a, b) => a.consultation_rate.compareTo(b.consultation_rate));
  //     case 1:
  //       consultants
  //           .sort((a, b) => b.consultation_rate.compareTo(a.consultation_rate));
  //       break;
  //   }
  //   return consultants;
  // }
}
