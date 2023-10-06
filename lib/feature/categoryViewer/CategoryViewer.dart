// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/core/widgets/responsiveconsultant.dart';
import 'package:naraakom/core/widgets/searchbar.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/consultantinfo.dart/consultantinfo.dart';
import 'package:naraakom/feature/mainbloc/Repository/repository.dart';
import 'package:naraakom/feature/mainbloc/contentbloc.dart';
import 'package:naraakom/feature/mainbloc/contentevent.dart';
import 'package:naraakom/feature/mainbloc/contentstate.dart';
import 'package:naraakom/feature/mainbloc/state/consultantsrequeststate.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/utils/Models/ConsultantModel.dart';
import '../../core/widgets/text700normal.dart';

class categoryViewer extends StatefulWidget {
  String category;
  String title;
  categoryViewer({super.key, required this.category, required this.title});

  @override
  State<categoryViewer> createState() => _categoryViewerState();
}

class _categoryViewerState extends State<categoryViewer> {
  String? selectedFilter; // Store the selected value here
  List<ConsultantModel>? filteredList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: homebackgrey,
      body: BlocProvider<contentbloc>(
        create: (context) {
          return contentbloc(context.read<Repository>())
            ..add(ConsultantsRequested())
            ..add(SelectCategoryEvent(widget.category));
        },
        child: Directionality(
          textDirection:
              defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: cyan,
                  expandedHeight: size.height * 0.08,
                  centerTitle: false,
                  title: text700normal(
                    text: widget.title,
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
      ),
    );
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
                    .add(SearchtextChangedEvent(onChanged, widget.category));
              }),
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
      },
    );
  }

  Widget _consultantsList() {
    return BlocBuilder<contentbloc, contentstate>(builder: (context, state) {
      if (state.requeststate is consultantsrequest_SUCCESS) {
        context.read<contentbloc>().add(SelectCategoryEvent(widget.category));
      }
      if (state.requeststate is CategorySelectedState) {
        filteredList =
            ((state.requeststate) as CategorySelectedState).filteredList;
        return _returnListView(filteredList!);
      }
      if (state.requeststate is SearchState) {
        filteredList =
            ((state.requeststate) as SearchState).searchedconsultants;
        return _returnListView(filteredList!);
      }
      return Container();
    });
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
                    text: language[defaultLang]['filterby'],
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
                text: language[defaultLang]['lowestprice'],
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
                text: language[defaultLang]['highestprice'],
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
}
