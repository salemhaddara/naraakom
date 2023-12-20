// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/core/widgets/Snackbar.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/booking/bookingScreen.dart';
import 'package:naraakom/feature/consultantinfo/bookingTracker/bookingTracker.dart';
import 'package:naraakom/feature/consultantinfo/bookingbloc/bookingEvent.dart';
import 'package:naraakom/feature/consultantinfo/bookingbloc/bookingState.dart';
import 'package:naraakom/feature/consultantinfo/bookingbloc/bookingbloc.dart';
import 'package:naraakom/feature/consultantinfo/repo/bookingRepository.dart';
import 'package:naraakom/feature/consultantinfo/widgets/DatePickerList.dart';
import 'package:naraakom/feature/consultantinfo/widgets/ReadMoreText.dart';
import 'package:naraakom/feature/consultantinfo/widgets/specializationsView.dart';
import 'package:naraakom/feature/consultantinfo/widgets/timePicker.dart';
import 'package:naraakom/feature/reviews/reviewsScreen.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/utils/Models/ConsultantModel.dart';
import '../../core/widgets/text400normal.dart';
import '../../core/widgets/text600normal.dart';
import '../signup/signupcomponents/siginrichtext.dart';

class consultantinfo extends StatefulWidget {
  final ConsultantModel? consultant;

  const consultantinfo({
    super.key,
    this.consultant,
  });

  @override
  State<consultantinfo> createState() => _consultantinfoState();
}

DateTime? SelectedDate;
DateTime? SelectedTime;

class _consultantinfoState extends State<consultantinfo> {
  List notifications = List.empty(growable: true);
  bool showedError = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    showedError = false;
    return Scaffold(
        backgroundColor: white,
        body: BlocProvider<bookingbloc>(
            create: (context) => bookingbloc(context.read<bookingRepository>()),
            child: Directionality(
              textDirection:
                  defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
              child: Container(
                  height: size.height,
                  padding: EdgeInsets.only(
                    top: size.height * .05,
                  ),
                  child: Stack(children: [
                    SizedBox(
                      height: size.height,
                      child: Column(children: [
                        _topbar(size),
                        Expanded(
                          child: ListView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              children: [
                                _consultantinfo(size),
                                _consultantEXPandVisitors(size),
                                _consultationPrice(size),
                                _advicefromsupport(size),
                                _spacer(10, size),
                                _title('${language[defaultLang]['biography']}',
                                    size),
                                _biographyparagraph(size),
                                _title(language[defaultLang]['specializations'],
                                    size),
                                _specializations(),
                                _title(
                                    language[defaultLang]['selectdate'], size),
                                _datepicker(),
                                _title(
                                    language[defaultLang]['selecttime'], size),
                                _timepicker(size, context),
                                _spacer(10, size),
                                _reviews(size)
                              ]),
                        )
                      ]),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 50),
                        child: button(
                            text: language[defaultLang]['bookappointment'],
                            width: size.width,
                            onTap: () {
                              if (SelectedTime != null) {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: bookingScreen(
                                    consultantinfos: widget.consultant!,
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: cyan,
                                        content: text700normal(
                                          color: white,
                                          text: language[defaultLang]
                                              ['selectdatebefore'],
                                          fontsize: 16,
                                        )));
                              }
                            }),
                      ),
                    )
                  ])),
            )));
  }

  _reviews(Size size) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (BuildContext context) {
            return reviewsScreen(
              consultantinfo: widget.consultant!,
            );
          },
        );
      },
      child: Container(
        height: 54,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 200),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13))),
        child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            elevation: 5,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                child: _reviewstile(
                    size, ' ${language[defaultLang]['reviews']}', true, true))),
      ),
    );
  }

  Widget _reviewstile(
    Size size,
    String text,
    bool radiustop,
    bool radiusdown,
  ) {
    return Container(
      height: 54,
      width: size.width,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiustop ? 10 : 0),
            topRight: Radius.circular(radiustop ? 10 : 0),
            bottomLeft: Radius.circular(radiustop ? 0 : 10),
            bottomRight: Radius.circular(radiustop ? 0 : 10),
          )),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        Expanded(
            child: text600normal(
          text: text,
          color: darkblack,
          fontsize: 16,
        )),
        SizedBox(
          width: 32,
          height: 32,
          child: Transform.rotate(
            angle: defaultLang == 'en' ? 3.14159265 : 0,
            child: SvgPicture.asset(
              'assets/images/back.svg',
            ),
          ),
        ),
      ]),
    );
  }

  _timepicker(Size size, BuildContext scaffoldContext) {
    return BlocBuilder<bookingbloc, bookingstate>(builder: (context, state) {
      if (state.tracker is selectDateSuccess &&
          state.timesAvailable != null &&
          state.timesAvailable!.isNotEmpty) {
        return TimePicker(
          bookingTimes: state.timesAvailable ?? [],
          onTimeSelected: (selectedTime) {
            final selectedBookingTime = state.timesAvailable?.firstWhere(
              (bookingTime) => bookingTime.bookingtime == selectedTime,
            );
            if (!selectedBookingTime!.available) {
              SelectedTime = selectedTime;
            }
          },
        );
      } else if (state.tracker is selectDateLoading) {
        return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 10),
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: cyan,
            ));
      } else {
        if (state.tracker is selectDateFailed && !showedError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(showSnackbar(
                (state.tracker as selectDateFailed).exception, size));
          });
        }
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: text400normal(
              text: language[defaultLang]['nobookingtimes'],
              color: grey,
              fontsize: 14),
        );
      }
    });
  }

  _datepicker() {
    return BlocBuilder<bookingbloc, bookingstate>(builder: (context, state) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: DatePickerList(
          itemCount: 30,
          onDateSelected: (DateTime date) {
            showedError = false;
            context
                .read<bookingbloc>()
                .add(getTimesinSpecificDate(date, widget.consultant!.user_id));
          },
          selectedDate: state.Selected,
        ),
      );
    });
  }

  _biographyparagraph(Size size) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: ReadMoreText(
          text: widget.consultant!.bio,
        ));
  }

  _title(String text, Size size) {
    return Container(
        margin: const EdgeInsets.all(16),
        width: size.width,
        child: text700normal(text: text, fontsize: 20, color: darkblack));
  }

  _spacer(double height, Size size) {
    return Container(
      height: height,
      color: lightcyan,
      width: size.width,
    );
  }

  _advicefromsupport(Size size) {
    return Container(
        width: size.width,
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Container(
            height: 34,
            width: 34,
            padding: const EdgeInsets.all(3),
            margin: const EdgeInsetsDirectional.only(end: 5),
            child: SvgPicture.asset(
              'assets/images/info.svg',
              height: 24,
              width: 24,
            ),
          ),
          Expanded(
            child: text400normal(
              text: '${language[defaultLang]['notice']}',
              color: lightblack,
              fontsize: 14,
            ),
          )
        ]));
  }

  _specializations() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: specializationsView(texts: widget.consultant!.departments));
  }

  _consultationPrice(Size size) {
    return Container(
        width: size.width,
        color: homebackgrey,
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          SvgPicture.asset(
            'assets/images/money.svg',
            height: 34,
            width: 34,
          ),
          signinrichtext(
            startText: '${language[defaultLang]['consultationprice']} : ',
            clickableText: '${widget.consultant!.fees.floor()} QAR',
            onClick: () {},
            fontsize: 18,
          ),
        ]));
  }

  _consultantEXPandVisitors(Size size) {
    return Container(
      width: size.width,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsetsDirectional.only(end: 15),
                  decoration: BoxDecoration(
                      color: lightcyan,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: SvgPicture.asset('assets/images/experienceicon.svg')),
              Column(
                children: [
                  Expanded(
                      child: text700normal(
                          text:
                              '${widget.consultant!.experience_yrs} ${language[defaultLang]['years']}',
                          fontsize: 18,
                          color: darkblack)),
                  Expanded(
                      child: text400normal(
                          text: language[defaultLang]['experience'],
                          fontsize: 14,
                          color: darkblack)),
                ],
              )
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsetsDirectional.only(end: 15),
                  decoration: BoxDecoration(
                      color: lightcyan,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: SvgPicture.asset('assets/images/visitorsicon.svg')),
              Column(
                children: [
                  Expanded(
                      child: text700normal(
                          text: '${widget.consultant!.visitors}+',
                          fontsize: 18,
                          color: darkblack)),
                  Expanded(
                      child: text400normal(
                          text: '${language[defaultLang]['visitors']}',
                          fontsize: 14,
                          color: darkblack)),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  _consultantinfo(Size size) {
    return Container(
        margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Material(
            elevation: 0,
            shadowColor: lightcyan,
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: SizedBox(
                height: 122,
                width: size.width,
                child: Column(children: [
                  SizedBox(
                    height: 110,
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: lightcyan,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(13))),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(13)),
                            child: Image.network(
                              widget.consultant!.profile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: AlignmentDirectional.centerStart,
                                child: text600normal(
                                    align: TextAlign.start,
                                    text: widget.consultant!.name,
                                    fontsize: 20,
                                    color: darkblack),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: AlignmentDirectional.centerStart,
                                child: text400normal(
                                    align: TextAlign.start,
                                    text: defaultLang == 'ar'
                                        ? widget
                                            .consultant!.specialitst_title_ar
                                        : widget
                                            .consultant!.specialitst_title_en,
                                    fontsize: 16,
                                    color: grey),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: AlignmentDirectional.centerStart,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/rating.svg'),
                                    text600normal(
                                        align: TextAlign.start,
                                        text: ' ${widget.consultant!.rate} ',
                                        fontsize: 14,
                                        color: darkblack),
                                    text400normal(
                                        align: TextAlign.start,
                                        text:
                                            '(${widget.consultant!.visitors} ${language[defaultLang]['visitors']})',
                                        fontsize: 14,
                                        color: grey),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: size.width,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    color: lightcyan,
                  ),
                ]))));
  }

  _topbar(Size size) {
    return Material(
      elevation: 1,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24))),
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Transform.rotate(
                angle: defaultLang == 'ar' ? 3.14159265 : 0,
                child: SvgPicture.asset(
                  'assets/images/back.svg',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: text600normal(
              text: '${language[defaultLang]['consultantinfo']}',
              fontsize: 20,
              color: lightblack,
            ),
          )
        ]),
      ),
    );
  }
}
