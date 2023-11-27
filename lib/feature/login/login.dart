// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/authRepository.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/inputfield.dart';
import 'package:naraakom/core/widgets/phoneinput.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/login/loginComponents/signuprichtext.dart';
import 'package:naraakom/feature/login/loginstates/loginbloc.dart';
import 'package:naraakom/feature/login/loginstates/loginevent.dart';
import 'package:naraakom/feature/login/loginstates/loginstate.dart';
import 'package:naraakom/feature/login/submission/submissionevent.dart';

import '../../core/widgets/Snackbar.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final formKey = GlobalKey<FormState>();
  bool Navigated = false;
  bool showedError = false;
  String phoneNumbercheck = '', passwordcheck = '', fullphoneNumber = '';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: BlocProvider(
        create: (context) => loginbloc(context.read<authRepository>()),
        child: SafeArea(
            child: Directionality(
          textDirection:
              defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _loginPhoto(size),
                  _SignInTitle(size),
                  _form(size),
                  _forgetPassword(size, context),
                  _signinButton(size, context),
                  _donthaveaccount(size)
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget _form(Size size) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _phoneNumberTitle(size),
          _phoneInputField(size),
          _passwordTitle(size),
          _passwordField(size),
        ],
      ),
    );
  }

  Widget _loginPhoto(Size size) {
    return SizedBox(
      height: size.height * .25,
      width: size.width,
      child: SvgPicture.asset(
        'assets/images/signin.svg',
        alignment: Alignment.center,
      ),
    );
  }

  Widget _SignInTitle(Size size) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        width: size.width,
        child: text700normal(
            text: language[defaultLang]['signin'],
            fontsize: 26,
            color: darkblack));
  }

  Widget _phoneNumberTitle(Size size) {
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

  Widget _phoneInputField(Size size) {
    return BlocBuilder<loginbloc, loginstate>(builder: (context, state) {
      return phoneinput(
        onChanged: (text) {
          phoneNumbercheck = text.number;
          fullphoneNumber = text.completeNumber;
          context
              .read<loginbloc>()
              .add(loginPhoneNumberChanged(phoneNumnber: text.completeNumber));
        },
      );
    });
  }

  Widget _passwordTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['password'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _passwordField(Size size) {
    return BlocBuilder<loginbloc, loginstate>(
      builder: (context, state) {
        return InputField(
          hint: '',
          isPassword: true,
          validator: (password) {
            context
                .read<loginbloc>()
                .add(loginPasswordrChanged(password: password));
            if (password!.isEmpty) {
              return null;
            }
            if (!state.isValidPassword) {
              return language[defaultLang]['passerror'];
            }
            return null;
          },
          initialState: true,
          onChanged: (text) {
            passwordcheck = text!;
          },
        );
      },
    );
  }

  Widget _forgetPassword(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
              showSnackbar(language[defaultLang]['forgetpasserror'], size));
        } else {
          Navigator.of(context).pushReplacementNamed(otpverificationRoute,
              arguments: fullphoneNumber);
        }
      },
      child: Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 5, bottom: 25),
        alignment: AlignmentDirectional.centerEnd,
        child: text400normal(
          text: language[defaultLang]['forgetpassword'],
          color: cyan,
          fontsize: 14,
        ),
      ),
    );
  }

  Widget _signinButton(Size size, BuildContext pagecontext) {
    return BlocBuilder<loginbloc, loginstate>(builder: (context, state) {
      if (state.formstatus is submissionsuccess && !Navigated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(pagecontext).pushReplacementNamed(homePageRoute);
        });
        Navigated = true;
        return Container();
      }
      if (state.formstatus is submissionfailed && !showedError) {
        print((state.formstatus as submissionfailed).exception);
        showedError = true;
      }
      return state.formstatus is formsubmitting
          ? CircularProgressIndicator(
              color: cyan,
              strokeWidth: 6,
            )
          : button(
              text: language[defaultLang]['signin'],
              onTap: () {
                if (phoneNumbercheck.isNotEmpty && passwordcheck.isNotEmpty) {
                  if (formKey.currentState!.validate()) {
                    context.read<loginbloc>().add((loginSubmitted()));
                  }
                }
                showedError = false;
              },
              width: size.width,
            );
    });
  }

  Widget _donthaveaccount(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: signuprichtext(
          startText: language[defaultLang]['donthaveaccount'],
          clickableText: language[defaultLang]['signup'],
          onClick: () {
            Navigator.pushNamed(context, signupRoute);
          }),
    );
  }
}
