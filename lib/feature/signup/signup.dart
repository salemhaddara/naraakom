import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/feature/signup/signupcomponents/acceptterms.dart';
import 'package:naraakom/feature/signup/signupstates/signupevent.dart';
import 'package:naraakom/feature/signup/signupstates/signupstate.dart';
import 'package:naraakom/feature/signup/signupsubmission/signupsubmissionevent.dart';
import '../../authrepository.dart';
import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/inputfield.dart';
import '../../core/widgets/phoneinput.dart';
import '../../core/widgets/text400normal.dart';
import '../../core/widgets/text700normal.dart';
import 'signupcomponents/siginrichtext.dart';
import 'signupstates/signupbloc.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final formKey = GlobalKey<FormState>();
  bool acceptedTerms = false;
  String phoneNumbercheck = '',
      namecheck = '',
      emailcheck = '',
      passwordcheck = '';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        systemNavigationBarIconBrightness: Brightness.light));
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: BlocProvider(
        create: (context) => signupbloc(context.read<authrepository>()),
        child: SafeArea(
            child: Directionality(
          textDirection:
              defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                _signUpImage(size),
                _signupTitle(size),
                _SignUpForm(size),
                _Spacer(30),
                _SignInRichText(size)
              ]),
            ),
          ),
        )),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _SignUpForm(Size size) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            _nameTitle(size),
            _nameInputField(size),
            _emailTitle(size),
            _emailInputField(size),
            _phoneNumberTitle(size),
            _phoneInputField(size),
            _passwordTitle(size),
            _passwordInputField(size),
            _acceptTermsTitle(size),
            _signUpButton(size, context)
          ],
        ));
  }

  Widget _signUpImage(Size size) {
    return Container(
      height: size.height * .20,
      width: size.width,
      margin: const EdgeInsets.only(bottom: 10),
      child: SvgPicture.asset(
        'assets/images/signup.svg',
        alignment: Alignment.center,
      ),
    );
  }

  Widget _signupTitle(Size size) {
    return Container(
        width: size.width,
        margin: const EdgeInsetsDirectional.only(bottom: 10),
        child: text700normal(
            text: language[defaultLang]['signup'],
            fontsize: 26,
            color: darkblack));
  }

  Widget _nameTitle(Size size) {
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

  Widget _nameInputField(Size size) {
    return InputField(
      hint: '',
      isPassword: false,
      color: homebackgrey,
      validator: (name) {
        if (name!.isEmpty) {
          return null;
        }
        if (name.length < 3) {
          return 'The Name Must be > 3 characters ';
        }
        return null;
      },
      initialState: false,
      onChanged: (text) {
        namecheck = '$text';
      },
    );
  }

  Widget _emailTitle(Size size) {
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

  Widget _emailInputField(Size size) {
    return InputField(
      hint: '',
      color: homebackgrey,
      isPassword: false,
      validator: (email) {
        if (email!.isEmpty) {
          return null;
        }
        if (!isValidEmail(email)) {
          return 'Enter A Valid Email Address';
        }
        return null;
      },
      initialState: false,
      onChanged: (text) {
        emailcheck = '$text';
      },
    );
  }

  Widget _SignInRichText(Size size) {
    return signinrichtext(
        startText: language[defaultLang]['haveaccount'],
        clickableText: language[defaultLang]['signin'],
        onClick: () {});
  }

  Widget _signUpButton(Size size, BuildContext pagecontext) {
    bool Navigated = false;
    return BlocBuilder<signupbloc, signupstate>(builder: (context, state) {
      if (state.formstatus is signupsubmissionsuccess && !Navigated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(pagecontext).pop();
        });
        Navigated = true;
        return Container();
      }
      return state.formstatus is signupformsubmitting
          ? CircularProgressIndicator(
              strokeWidth: 6,
              color: cyan,
            )
          : button(
              text: language[defaultLang]['signup'],
              onTap: () {
                if (formKey.currentState!.validate()) {
                  if (acceptedTerms &&
                      namecheck.isNotEmpty &&
                      emailcheck.isNotEmpty &&
                      phoneNumbercheck.isNotEmpty &&
                      passwordcheck.isNotEmpty) {
                    context.read<signupbloc>().add((signupSubmitted()));
                  }
                }
              },
              width: size.width,
            );
    });
  }

  Widget _acceptTermsTitle(Size size) {
    return acceptterms(onChangedState: (newvalue) {
      acceptedTerms = newvalue;
    });
  }

  Widget _passwordInputField(Size size) {
    return BlocBuilder<signupbloc, signupstate>(
      builder: (context, state) {
        return InputField(
          hint: '',
          isPassword: true,
          validator: (password) {
            context
                .read<signupbloc>()
                .add(signupPasswordrChanged(password: password));
            if (password!.isEmpty) {
              return null;
            }
            if (!state.isValidPassword) {
              return 'Password Must be >8 characters';
            }
            return null;
          },
          initialState: true,
          onChanged: (text) {
            passwordcheck = '$text';
          },
        );
      },
    );
  }

  Widget _passwordTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['password'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _phoneInputField(Size size) {
    return phoneinput(
      onChanged: (text) {
        phoneNumbercheck = text.number;
      },
    );
  }

  Widget _phoneNumberTitle(Size size) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: text400normal(
        text: language[defaultLang]['phonenumber'],
        color: lightblack,
        fontsize: 14,
      ),
    );
  }

  Widget _Spacer(double height) {
    return SizedBox(
      height: height,
    );
  }

  bool isValidEmail(String email) {
    RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }
}
