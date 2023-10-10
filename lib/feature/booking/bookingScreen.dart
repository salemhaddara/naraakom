// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/feature/booking/Repository/bookingappointmentRepo.dart';
import 'package:naraakom/feature/booking/bloc/bookingbloc.dart';
import 'package:naraakom/feature/booking/bloc/bookingevent.dart';
import 'package:naraakom/feature/booking/bloc/bookingstate.dart';
import 'package:naraakom/feature/booking/bookingSuccessful.dart';
import 'package:naraakom/feature/consultantinfo.dart/consultantinfo.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/widgets/inputfield.dart';
import '../../core/widgets/phoneinput.dart';
import '../../core/widgets/text400normal.dart';
import '../PaymentMethod/paymentmethod.dart';

class bookingScreen extends StatefulWidget {
  ConsultantModel consultantinfos;
  bookingScreen({super.key, required this.consultantinfos});

  @override
  State<bookingScreen> createState() => _bookingScreenState();
}

class _bookingScreenState extends State<bookingScreen> {
  String? calltype;
  int shemaIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String emailcheck = '', namecheck = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: white,
      body: BlocProvider(
          create: (context) =>
              bookingAppointmentbloc(context.read<bookingappointmentRepo>()),
          child: Directionality(
              textDirection:
                  defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
              child: Container(
                padding: EdgeInsets.only(
                  top: size.height * .05,
                ),
                child: Column(children: [
                  _topbar(size),
                  _bookingInfo(size),
                  _spacer(5, size),
                  BlocBuilder<bookingAppointmentbloc, bookingAppointmentstate>(
                      builder: (context, state) {
                    return _schema(state.index, size);
                  }),
                  _spacer(2, size),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: BlocBuilder<bookingAppointmentbloc,
                          bookingAppointmentstate>(builder: (context, state) {
                        return Column(
                          children: [
                            if (state.index == 0)
                              _schemaCallType(size, context)
                            else if (state.index == 1)
                              _schemacontactInfo(size, context)
                            else if (state.index == 2)
                              _schemaCase(size, context)
                            else if (state.index == 3)
                              _schemapaymentInfo(size, context)
                          ],
                        );
                      }),
                    ),
                  )
                ]),
              ))),
    );
  }

  _schemapaymentInfo(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: cyan,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return const PaymentMethodsBottomSheet();
                  },
                );
              },
              child: Container(
                height: 30,
                width: size.width,
                alignment: Alignment.center,
                child: Row(children: [
                  Icon(
                    Icons.add,
                    color: cyan,
                  ),
                  text400normal(
                      text: language[defaultLang]['addnewpaymentmethod'],
                      color: cyan,
                      fontsize: 16),
                ]),
              )),
          const SizedBox(
            height: 150,
          ),
          button(
              text: language[defaultLang]['completepayment'],
              width: size.width,
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: bookingSuccessful(
                    consultant: widget.consultantinfos,
                    dateAndTime: language[defaultLang]['datetime'],
                    appointmentType: calltype ?? '',
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              })
        ],
      ),
    );
  }

  _schema(int index, Size size) {
    return Container(
      width: size.width,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16, bottom: 10),
      child: Row(children: [
        Expanded(
            child: Column(
          children: [
            if (index == 0)
              SvgPicture.asset(
                'assets/images/phone.svg',
                height: 24,
                width: 24,
              )
            else if (index > 0)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/phonegrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
                text: language[defaultLang]['calltype'],
                fontsize: 14,
                color: index >= 0 ? cyan : grey)
          ],
        )),
        Container(
          height: 1,
          width: 20,
          color: grey,
        ),
        Expanded(
            child: Column(
          children: [
            if (index == 1)
              SvgPicture.asset(
                'assets/images/contactinfo.svg',
                height: 24,
                width: 24,
              )
            else if (index > 1)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/contactinfogrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
              text: language[defaultLang]['contactinfo'],
              fontsize: 13,
              color: index >= 1 ? cyan : grey,
              align: TextAlign.center,
            ),
          ],
        )),
        Container(
          height: 1,
          width: 20,
          color: grey,
        ),
        Expanded(
            child: Column(
          children: [
            if (index == 2)
              SvgPicture.asset(
                'assets/images/case.svg',
                height: 24,
                width: 24,
              )
            else if (index > 2)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/casegrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
              text: language[defaultLang]['case'],
              fontsize: 14,
              color: index >= 2 ? cyan : grey,
            )
          ],
        )),
        Container(
          height: 1,
          width: 20,
          color: grey,
        ),
        Expanded(
            child: Column(
          children: [
            if (index == 3)
              SvgPicture.asset(
                'assets/images/payment.svg',
                height: 24,
                width: 24,
              )
            else if (index > 3)
              SvgPicture.asset(
                'assets/images/done.svg',
                height: 24,
                width: 24,
              )
            else
              SvgPicture.asset(
                'assets/images/paymentgrey.svg',
                height: 24,
                width: 24,
              ),
            const Spacer(),
            text400normal(
              text: language[defaultLang]['payment'],
              fontsize: 14,
              color: index >= 3 ? cyan : grey,
            )
          ],
        )),
      ]),
    );
  }

  _schemaCase(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Form(
          child: Column(
        children: [
          _notice(size),
          _schemaCaseAgeTitle(size),
          _schemaCaseAgeInputField(size),
          _schemaCaseDescriptionTitle(size),
          _schemaCaseInputField(size),
          _schemaCaseContinueButton(size, context),
          _schemaCaseCancelButton(size, context)
        ],
      )),
    );
  }

  _notice(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: text400normal(
          text: language[defaultLang]['additionalinformation'],
          color: grey,
          fontsize: 14),
    );
  }

  Widget _schemaCaseAgeTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['age'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _schemaCaseAgeInputField(Size size) {
    return InputField(
      hint: '',
      isPassword: false,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }

        return null;
      },
      initialState: false,
      onChanged: (text) {},
    );
  }

  Widget _schemaCaseDescriptionTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['case'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _schemaCaseInputField(Size size) {
    return InputField(
      hint: '',
      isPassword: false,
      height: 108,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }

        return null;
      },
      initialState: false,
      onChanged: (text) {},
    );
  }

  Widget _schemaCaseContinueButton(Size size, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25, bottom: 16),
        child: button(
            text: language[defaultLang]['proceedtopayment'],
            width: size.width,
            onTap: () {
              context
                  .read<bookingAppointmentbloc>()
                  .add(bookingSchemaIndexChanged());
            }));
  }

  Widget _schemaCaseCancelButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<bookingAppointmentbloc>()
            .add(bookingSchemaCancelInvoked());
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: text600normal(
              text: language[defaultLang]['cancel'],
              color: cyan,
              fontsize: 16)),
    );
  }

  _schemacontactInfo(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Form(
          key: formKey,
          child: Column(
            children: [
              _schemacontactInfonameTitle(size),
              _schemacontactInfonameField(size),
              _schemacontactInfoemailTitle(size),
              _schemacontactInfoemailInputField(size),
              _schemacontactInfophoneNumberTitle(size),
              _schemacontactInfophoneInputField(size),
              __schemacontactInfoContinueButton(size, context),
              __schemacontactInfoCancelButton(size, context)
            ],
          )),
    );
  }

  Widget _schemacontactInfoemailTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['email'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _schemacontactInfoemailInputField(Size size) {
    return InputField(
      hint: '',
      color: homebackgrey,
      isPassword: false,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }
        if (!isValidEmail(email)) {
          return language[defaultLang]['enteravalidemail'];
        }
        return null;
      },
      initialState: false,
      onChanged: (text) {
        emailcheck = '$text';
      },
    );
  }

  bool isValidEmail(String email) {
    RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  Widget __schemacontactInfoContinueButton(Size size, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25, bottom: 16),
        child: button(
            text: language[defaultLang]['continue'],
            width: size.width,
            onTap: () {
              if (formKey.currentState!.validate() &&
                  emailcheck.isNotEmpty &&
                  namecheck.isNotEmpty) {
                context
                    .read<bookingAppointmentbloc>()
                    .add(bookingSchemaIndexChanged());
              }
            }));
  }

  Widget __schemacontactInfoCancelButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<bookingAppointmentbloc>()
            .add(bookingSchemaCancelInvoked());
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: text600normal(
              text: language[defaultLang]['cancel'],
              color: cyan,
              fontsize: 16)),
    );
  }

  Widget _schemacontactInfophoneNumberTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 26, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['phonenumber'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _schemacontactInfophoneInputField(Size size) {
    return phoneinput(
      color: homebackgrey,
      onChanged: (text) {},
    );
  }

  Widget _schemacontactInfonameTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['name'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _schemacontactInfonameField(Size size) {
    return InputField(
      hint: '',
      isPassword: false,
      color: homebackgrey,
      validator: (name) {
        if (name!.isEmpty) {
          return null;
        }
        if (name.length < 3) {
          return language[defaultLang]['namerror'];
        }
        return null;
      },
      initialState: false,
      onChanged: (text) {
        namecheck = '$text';
      },
    );
  }

  _schemaCallType(Size size, BuildContext context) {
    return Column(
      children: [
        _callTypeStepTitle(size),
        _callTypeStepCallsType(size, context),
        _callTypeStepCallsNotice(size),
        _callTypeStepCallsPickanotherTime()
      ],
    );
  }

  _callTypeStepCallsType(Size size, BuildContext context) {
    return Container(
      width: size.width,
      height: 120,
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          _callTypeStepCallItem(
              size, language[defaultLang]['videocall'], 'videocall', () {
            calltype = 'videocall';
            context
                .read<bookingAppointmentbloc>()
                .add(bookingSchemaIndexChanged());
          }),
          const SizedBox(
            width: 10,
          ),
          _callTypeStepCallItem(
              size, language[defaultLang]['voicecall'], 'voicecall', () {
            calltype = 'voicecall';
            context
                .read<bookingAppointmentbloc>()
                .add(bookingSchemaIndexChanged());
          }),
          const SizedBox(
            width: 10,
          ),
          _callTypeStepCallItem(size, language[defaultLang]['chat'], 'chatcall',
              () {
            calltype = 'chatcall';
            context
                .read<bookingAppointmentbloc>()
                .add(bookingSchemaIndexChanged());
          }),
        ],
      ),
    );
  }

  _callTypeStepCallsPickanotherTime() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        child: text400normal(
          text: language[defaultLang]['pickanothertime'],
          color: lightblack,
          fontsize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  _callTypeStepCallsNotice(Size size) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: text400normal(
          text: language[defaultLang]['allvideocalls'],
          color: grey,
          fontsize: 13),
    );
  }

  _callTypeStepCallItem(Size size, String type, String image, Function onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Material(
          elevation: 1,
          color: white,
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13))),
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Expanded(
                  flex: 2,
                  child: SvgPicture.asset(
                    'assets/images/$image.svg',
                    height: 34,
                    width: 34,
                  )),
              Expanded(
                  flex: 1,
                  child: text600normal(
                      text: type, fontsize: 16, color: darkblack)),
            ]),
          ),
        ),
      ),
    );
  }

  _callTypeStepTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(16),
      child: text600normal(
          text: language[defaultLang]['howwouldyouliketospeak'],
          fontsize: 16,
          color: darkblack),
    );
  }

  _spacer(double height, Size size) {
    return Container(
      height: height,
      color: lightcyan,
      width: size.width,
    );
  }

  _bookingInfo(Size size) {
    return Container(
      width: size.width,
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      color: lightcyan,
      child: Column(children: [
        _bookinginforowspecialist(),
        _bookinginforowconsultationPrice(),
        _bookinginfofortime()
      ]),
    );
  }

  _bookinginfofortime() {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/iconschedule.svg',
              height: 30,
              width: 30,
            ),
            text400normal(
              text: language[defaultLang]['datetime'],
              color: grey,
              fontsize: 16,
            )
          ],
        )),
        Expanded(
            child: Row(
          children: [
            text600normal(
              text: formatDateTime(SelectedTime!),
              color: grey,
              fontsize: 16,
            )
          ],
        )),
      ],
    ));
  }

  String formatDateTime(DateTime dateTime) {
    final intl.DateFormat formatter = intl.DateFormat('dd/MM/yyyy | hh:mm a');
    return formatter.format(dateTime);
  }

  _bookinginforowconsultationPrice() {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/money.svg',
              height: 30,
              width: 30,
            ),
            text400normal(
              text: language[defaultLang]['consultationprice'],
              color: grey,
              fontsize: 16,
            )
          ],
        )),
        Expanded(
            child: Row(
          children: [
            text600normal(
              text: '${widget.consultantinfos.consultation_rate.floor()} QAR',
              color: cyan,
              fontsize: 16,
            )
          ],
        )),
      ],
    ));
  }

  _bookinginforowspecialist() {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/specialist.svg',
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            text400normal(
              text: language[defaultLang]['specialization'],
              color: grey,
              fontsize: 16,
            )
          ],
        )),
        Expanded(
            child: Row(
          children: [
            text400normal(
              text: widget.consultantinfos.category,
              color: grey,
              fontsize: 16,
            )
          ],
        )),
      ],
    ));
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
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: text600normal(
                  text: '${language[defaultLang]['confirmbooking']}/',
                  fontsize: 20,
                  color: lightblack,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: text400normal(
                  text: widget.consultantinfos.name,
                  fontsize: 20,
                  color: lightblack,
                ),
              ),
            ])));
  }
}
