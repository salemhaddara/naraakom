import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/widgets/text700normal.dart';

import '../../config/localisation/translation.dart';
import '../../config/theme/colors.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/inputfield.dart';
import '../../core/widgets/text400normal.dart';
import '../../core/widgets/text600normal.dart';

class setnewpass extends StatefulWidget {
  const setnewpass({super.key});

  @override
  State<setnewpass> createState() => _setnewpassState();
}

class _setnewpassState extends State<setnewpass> {
  String passwordcheck = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body:
          // BlocProvider(
          //   create: (context) => signupbloc(context.read<authrepository>()),
          //   child:
          SafeArea(
              child: Directionality(
        textDirection:
            defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              _topbar(size),
              _setpassImage(size),
              _newpass(size),
              _passwordField(size),
              _confirmpass(size),
              _confirmpasswordField(size),
              _spacer(40),
              _submitnewpassButton(size)
            ]),
          ),
        ),
      )),
      // ),
    );
  }

  Widget _submitnewpassButton(Size size) {
    // return BlocBuilder<loginbloc, loginstate>(builder: (context, state) {
    return
        // state.formstatus is formsubmitting
        //     ? CircularProgressIndicator(
        //         color: cyan,
        //       )
        //     :
        button(
      text: language[defaultLang]['confirmpass'],
      onTap: () {
        // print(passwordcheck);
        // if (phoneNumbercheck.isNotEmpty && passwordcheck.isNotEmpty) {
        //   if (formKey.currentState!.validate()) {
        //     context.read<loginbloc>().add((loginSubmitted()));
        //   }
        // }
      },
      width: size.width,
    );
    // });
  }

  Widget _spacer(double space) {
    return SizedBox(
      height: space,
    );
  }

  Widget _confirmpasswordField(Size size) {
    // return BlocBuilder<loginbloc, loginstate>(
    //   builder: (context, state) {
    return InputField(
      hint: language[defaultLang]['renternewpass'],
      isPassword: true,
      validator: (password) {
        return null;

        // context
        //     .read<loginbloc>()
        //     .add(loginPasswordrChanged(password: password));
        // if (password!.isEmpty) {
        //   return null;
        // }
        // if (!state.isValidPassword) {
        //   return language[defaultLang]['passerror'];
        // }
        // return null;
      },
      initialState: true,
      onChanged: (text) {
        passwordcheck = text!;
      },
    );
    // },
    // );
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
    // return BlocBuilder<loginbloc, loginstate>(
    //   builder: (context, state) {
    return InputField(
      hint: language[defaultLang]['enternewpass'],
      isPassword: true,
      validator: (password) {
        return null;

        // context
        //     .read<loginbloc>()
        //     .add(loginPasswordrChanged(password: password));
        // if (password!.isEmpty) {
        //   return null;
        // }
        // if (!state.isValidPassword) {
        //   return language[defaultLang]['passerror'];
        // }
        // return null;
      },
      initialState: true,
      onChanged: (text) {
        passwordcheck = text!;
      },
    );
    // },
    // );
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
