import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:lottie/lottie.dart';
import 'package:naraakom/feature/resetpassword/otpComponents/otpinputField.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpevent.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpstate.dart';
import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';
import 'package:naraakom/feature/resetpassword/setnewpass.dart';
import '../../authrepository.dart';
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
  bool isError = false;
  bool isNavigated = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String phonenumber = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: white,
      body: BlocProvider(
        create: (context) => otpbloc(context.read<authrepository>())
          ..add(otpPhoneNumberChanged(phoneNumber: phonenumber))
          ..add(otpSubmitted()),
        child: BlocBuilder<otpbloc, otpstate>(builder: (context, state) {
          if (state.formstatus is otpformsubmitting) {
            return Align(
              child: CircularProgressIndicator(color: cyan),
            );
          } else if (state.formstatus is otpsubmissionfailed) {
            return const Align(
              alignment: Alignment.center,
              child: Text('failed '),
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
          context.read<otpbloc>().add(otpSubmitted());
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
      if (state.formstatus is otpverifiyingsuccess && !isNavigated) {
        isNavigated = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => setnewpass(mybloc: mybloc)));
        });
        return Container();
      }
      if (state.formstatus is otpverifiyingfailed) {
        //show error in the fields
        isError = true;
      }
      return state.formstatus is otpverifying
          ? CircularProgressIndicator(
              color: cyan,
            )
          : button(
              text: language[defaultLang]['verify'],
              width: size.width,
              onTap: () {
                //take the priovided code and send it here
                if (codeProvided.length == 4) {
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
      return OtpInputFields(
          onChange: (text) {},
          isError: state.isError,
          onOtpComplete: (text) {
            codeProvided = text;
          });
    });
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
