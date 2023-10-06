// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpbloc.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpevent.dart';
import 'package:naraakom/feature/resetpassword/otpstates/otpstate.dart';
import 'package:naraakom/feature/resetpassword/otpsubmission/otpsubmission.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/inputfield.dart';
import '../../core/widgets/text400normal.dart';
import '../../core/widgets/text600normal.dart';

class setnewpass extends StatefulWidget {
  otpbloc mybloc;
  setnewpass({super.key, required this.mybloc});

  @override
  State<setnewpass> createState() => _setnewpassState();
}

class _setnewpassState extends State<setnewpass> {
  String passwordcheck = '';
  String passwordconfirmation = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late otpbloc mybloc;
  //Get This from otp Verification
  String UserId = 'userid';

  bool isNavigated = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    mybloc = widget.mybloc;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Directionality(
        textDirection:
            defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
        child: BlocProvider.value(
          value: mybloc..add(userIdChanged(userId: UserId)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                  children: [_topbar(size), _setpassImage(size), _form(size)]),
            ),
          ),
        ),
      )),
      // ),
    );
  }

  Widget _submitnewpassButton(Size size, BuildContext context) {
    return BlocBuilder<otpbloc, otpstate>(builder: (context, state) {
      if (state.formstatus is settingNewPasswordSUCCESS && !isNavigated) {
        isNavigated = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, homePageRoute);
        });
        return Container();
      }
      if (state.formstatus is settingNewPasswordINPROGRESS) {
        return CircularProgressIndicator(
          strokeWidth: 6,
          color: cyan,
        );
      } else {
        return button(
          text: language[defaultLang]['confirmpass'],
          onTap: () async {
            if (formkey.currentState!.validate() && passwordcheck.isNotEmpty) {
              context.read<otpbloc>().add(newPassSubmitted());
            }
          },
          width: size.width,
        );
      }
    });
  }

  _form(Size size) {
    return Form(
        key: formkey,
        child: Column(
          children: [
            _newpass(size),
            _passwordField(size),
            _confirmpass(size),
            _confirmpasswordField(size),
            _spacer(40),
            _submitnewpassButton(size, context)
          ],
        ));
  }

  Widget _spacer(double space) {
    return SizedBox(
      height: space,
    );
  }

  Widget _confirmpasswordField(Size size) {
    return InputField(
      hint: language[defaultLang]['renternewpass'],
      isPassword: true,
      validator: (password) {
        if (passwordconfirmation != passwordcheck) {
          return language[defaultLang]['passdontmatch'];
        }
        return null;
      },
      initialState: true,
      onChanged: (text) {
        passwordconfirmation = text!;
      },
    );
  }

  Widget _confirmpass(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['confirmpass'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _passwordField(Size size) {
    return BlocBuilder<otpbloc, otpstate>(builder: (context, state) {
      return InputField(
        hint: language[defaultLang]['enternewpass'],
        isPassword: true,
        validator: (password) {
          if (passwordcheck.isNotEmpty && passwordcheck.length < 8) {
            return language[defaultLang]['passerror'];
          }
          return null;
        },
        initialState: true,
        onChanged: (text) {
          passwordcheck = text!;
          context.read<otpbloc>().add(newPassChanged(newPass: text));
        },
      );
    });
  }

  Widget _newpass(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['newpass'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  _topbar(Size size) {
    return Container(
      width: size.width,
      height: 54,
      color: white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(loginRoute);
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
            text: language[defaultLang]['resetpass'],
            fontsize: 20,
            color: lightblack,
          ),
        )
      ]),
    );
  }

  _setpassImage(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height * .20,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Image.asset('assets/images/setpass.png'),
    );
  }
}
