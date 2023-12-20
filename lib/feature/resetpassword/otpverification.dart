// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/utils/Preferences/Preferences.dart';
import 'package:naraakom/core/widgets/Snackbar.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:lottie/lottie.dart';
import 'package:naraakom/feature/resetpassword/otpComponents/otpinputField.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpevent.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpstate.dart';
import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';
import 'package:naraakom/feature/splash/splash.dart';
import '../../authRepository.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/widgets/text400normal.dart';
import 'otpstates/otpbloc.dart';

class otpverification extends StatefulWidget {
  const otpverification({
    super.key,
  });

  @override
  State<otpverification> createState() => _otpverificationState();
}

class _otpverificationState extends State<otpverification> {
  bool resendauthorized = true;
  String codeProvided = '';
  bool showedError = false;
  bool isNavigated = false;
  late String phonenumber;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    phonenumber = ModalRoute.of(context)!.settings.arguments as String;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: white,
      body: BlocProvider(
        create: (context) => otpbloc(context.read<authRepository>())
          ..add(otpPhoneNumberChanged(phoneNumber: phonenumber))
          ..add(otpRequested()),
        child: SafeArea(
          child: BlocBuilder<otpbloc, otpstate>(builder: (context, state) {
            if (state.formstatus is otpformsubmitting) {
              return Align(
                child: CircularProgressIndicator(color: cyan),
              );
            } else if (state.formstatus is otpsendingfailed) {
              return Align(
                alignment: Alignment.center,
                child: Text((state.formstatus as otpsendingfailed).exception),
              );
            } else {
              return SafeArea(
                  child: Directionality(
                textDirection:
                    defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      _title(size),
                      _sendedMessage(size, phonenumber),
                      _otpLottie(size),
                      _otpFields(size),
                      _submitButton(size, context, BlocProvider.of(context)),
                      _sendagain(size, context),
                      _changePhoneNumber(size, context),
                    ]),
                  ),
                ),
              ));
            }
          }),
        ),
      ),
    );
  }

  Widget _changePhoneNumber(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, loginRoute);
      },
      child: Container(
          width: size.width,
          margin: const EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          child: text600normal(
            fontsize: 16,
            text: language[defaultLang]['changenumber'],
            color: cyan,
          )),
    );
  }

  Widget _sendagain(Size size, BuildContext context) {
    return Visibility(
      visible: resendauthorized,
      child: GestureDetector(
        onTap: () {
          context.read<otpbloc>().add(otpRequested());
          resendauthorized = false;
        },
        child: Container(
            width: size.width,
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: text400normal(
              fontsize: 16,
              text: language[defaultLang]['sendagain'],
              color: lightblack,
              decoration: TextDecoration.underline,
            )),
      ),
    );
  }

  Widget _submitButton(
      Size size, BuildContext contextScaffold, otpbloc mybloc) {
    return BlocBuilder<otpbloc, otpstate>(builder: (context, state) {
      return state.formstatus is otpverifying
          ? CircularProgressIndicator(
              color: cyan,
            )
          : button(
              text: language[defaultLang]['verify'],
              width: size.width,
              onTap: () async {
                if (codeProvided.length == 6) {
                  context
                      .read<otpbloc>()
                      .add(otpcodeprovidedChanged(codeprovided: codeProvided));
                  context.read<otpbloc>().add(otpVerifyClicked());
                }
              },
            );
    });
  }

  Widget _otpFields(Size size) {
    return BlocBuilder<otpbloc, otpstate>(builder: (context, state) {
      if ((state.formstatus is otpvalidationfailed && !showedError)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(showSnackbar(
              (state.formstatus as otpvalidationfailed).message, size));
        });
        showedError = true;
      }

      if ((state.formstatus is otpvalidationsuccess && !isNavigated)) {
        navigate();
        isNavigated = true;
      }
      return OtpInputFields(
          onChange: (text) {},
          isError: (state.formstatus is otpvalidationfailed),
          onOtpComplete: (text) {
            showedError = false;
            codeProvided = text;
          });
    });
  }

  navigate() async {
    if ((await Preferences.getAuthOperation()) == 'signup') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, homePageRoute);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, setnewpassRoute,
            arguments: phonenumber);
      });
    }
  }

  Widget _otpLottie(Size size) {
    return Container(
      height: size.height * 0.25,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: Lottie.asset('assets/animations/otp.json'),
    );
  }

  Widget _sendedMessage(Size size, String phone) {
    return Container(
        width: (size.width) / 2,
        alignment: Alignment.center,
        child: text400normal(
            text: '${language[defaultLang]['sendedmessageto']} $phone',
            align: TextAlign.center,
            fontsize: 16,
            color: lightblack));
  }

  Widget _title(Size size) {
    return Container(
        width: (size.width) / 2,
        margin: const EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: text700normal(
            text: language[defaultLang]['enterverificationcode'],
            align: TextAlign.center,
            fontsize: 24,
            color: lightblack));
  }
}
