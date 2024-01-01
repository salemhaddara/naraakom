// ignore_for_file: camel_case_types,file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/widgets/responsiveconsultant.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/categoryViewer/CategoryViewer.dart';
import 'package:naraakom/feature/consultantinfo/consultantinfo.dart';
import 'package:naraakom/feature/home/widgets/autoslider.dart';
import 'package:naraakom/feature/home/widgets/popularbar.dart';
import 'package:naraakom/feature/home/Repository/repository.dart';
import 'package:naraakom/feature/home/states/contentbloc.dart';
import 'package:naraakom/feature/home/states/contentstate.dart';
import 'package:naraakom/feature/home/tracker/consultantsrequeststate.dart';
import 'package:naraakom/feature/home/tracker/specialistsrequeststate.dart';
import 'package:naraakom/feature/notifications/notificationScreen.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/utils/Models/User.dart';
import 'states/contentevent.dart';
import 'widgets/sliderbutton.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int yourActiveIndex = 0;
  String name = '';
  User? userdata;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: BlocProvider<contentbloc>(
        create: (context) {
          return contentbloc(context.read<Repository>())
            ..add(SpecialistsRequested())
            ..add(ConsultantsRequested());
        },
        child: Directionality(
          textDirection:
              defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: cyan,
                  expandedHeight: size.height * 0.12,
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
                    background: _buildHomeTopBar(size, context),
                  ),
                ),
              ];
            },
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _slider(size),
                      _categories(size),
                      _divider(10),
                      popularbar(
                        width: size.width,
                        height: 50,
                      ),
                      _popularConsultants(),
                      _ad(size)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _popularConsultants() {
    List<ConsultantModel> consultants = List.empty(growable: true);
    return BlocBuilder<contentbloc, contentstate>(builder: (context, state) {
      if (state.requeststate is consultantsrequest_IN_PROGRESS) {
        return Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: cyan,
            ));
      }
      if (state.requeststate is consultantsrequest_FAILED) {
        return const Text(
          '',
          style: TextStyle(color: Colors.red),
        );
      }
      if (state.requeststate is consultantsrequest_SUCCESS) {
        consultants.addAll(state.consultants!.toList());
        return Column(
          children: [
            responiveconsultant(
              islarge: false,
              consultant: consultants[0],
              onClick: () {},
              onclicknotlarge: () {
                Future.delayed(Duration.zero, () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: consultantinfo(
                      consultant: consultants[0],
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                });
              },
            ),
          ],
        );
      }
      return Container();
    });
  }

  Widget _ad(Size size) {
    return AspectRatio(
      aspectRatio: 14 / 7,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: Stack(
                  children: <Widget>[
                    // Background Image
                    Image.asset(
                      'assets/images/ad.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        alignment: AlignmentDirectional.topStart,
                        height: constraints.maxHeight / 2,
                        width: constraints.maxWidth / 1.2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                text700normal(
                                  text: language[defaultLang]
                                      ['thebestConsultant'],
                                  fontsize: 16,
                                  color: darkblack,
                                ),
                                const Spacer()
                              ],
                            ),
                            Row(
                              children: [
                                text400normal(
                                  text: language[defaultLang]
                                      ['followwithvoiceandvideo'],
                                  fontsize: 14,
                                  color: darkblack,
                                  align: TextAlign.start,
                                ),
                                const Spacer()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Position the "Book Now" text at the bottom-left corner
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: sliderbutton(
                        text: language[defaultLang]['booknow'],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _divider(double height) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: height,
      color: homebackgrey,
    );
  }

  Widget _categories(Size size) {
    return BlocBuilder<contentbloc, contentstate>(builder: (context, state) {
      if (state.specialistsrequestTracker is specialistsFetchingSUCCESSFUL) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          color: homebackgrey,
          child: Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(state.categories!.length, (index) {
                return _categoryContainer(
                    size,
                    'assets/images/professionalconsultant.svg',
                    defaultLang == 'en'
                        ? state.categories![index].title_en
                        : state.categories![index].title_ar, () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: categoryViewer(
                      specialistId: state.categories![index].id,
                      title: defaultLang == 'en'
                          ? state.categories![index].title_en
                          : state.categories![index].title_ar,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                });
              })),
        );
      }
      return Container();
    });
  }

  Widget _categoryContainer(
      Size size, String image, String text, Function onClick) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        width: (size.width < 600) ? size.width / 4 : size.width / 7,
        height: (size.width < 600) ? size.width / 4 : size.width / 7,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: white,
            border: Border.all(color: lightblack, width: 0.2),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Column(children: [
          Expanded(flex: 2, child: SvgPicture.asset(image)),
          Expanded(
              child: text700normal(
            text: text,
            fontsize: 12,
            color: darkblack,
            align: TextAlign.center,
          ))
        ]),
      ),
    );
  }

  Widget _slider(Size size) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 15), child: const AutoSlider()),
      ],
    );
  }

  Widget _buildHomeTopBar(Size size, BuildContext bloccontext) {
    return BlocBuilder<contentbloc, contentstate>(builder: (context, state) {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      margin: EdgeInsets.only(top: constraints.maxHeight * 0.3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/logoimagewhite.svg',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: constraints.maxHeight * 0.2,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      text600normal(
                                        text:
                                            '${language[defaultLang]['hello']}${state.userName ?? ''} ',
                                        fontsize: 20,
                                        color: white,
                                        align: TextAlign.start,
                                      ),
                                      Visibility(
                                        visible: userdata != null,
                                        child: SvgPicture.asset(
                                            'assets/images/imoji.svg'),
                                      ),
                                    ],
                                  ),
                                ),
                                text400normal(
                                  text:
                                      '${language[defaultLang]['haveaniceday']}✋',
                                  color: white,
                                  fontsize: 14,
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const notificationScreen(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: white),
                              child: Stack(children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                        'assets/images/notification.svg')),
                                // Visibility(
                                //   visible: userdata != null
                                //       ? NotificationModel.hasUnreadNotification(
                                //           userdata!.notifications)
                                //       : false,
                                //   child: Container(
                                //     height: 8,
                                //     width: 8,
                                //     margin: const EdgeInsets.all(7),
                                //     decoration: const BoxDecoration(
                                //         borderRadius: BorderRadius.all(
                                //             Radius.circular(4)),
                                //         color: Colors.red),
                                //   ),
                                // )
                              ]),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
