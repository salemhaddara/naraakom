import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/authrepository.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/widgets/Snackbar.dart';
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
  String passwordconfirmation = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Directionality(
        textDirection:
            defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
                children: [_topbar(size), _setpassImage(size), _form(size)]),
          ),
        ),
      )),
      // ),
    );
  }

  Widget _submitnewpassButton(Size size, BuildContext context) {
    return button(
      text: language[defaultLang]['confirmpass'],
      onTap: () async {
        if (formkey.currentState!.validate() && passwordcheck.isNotEmpty) {
          bool check = await authrepository.setNewPass('password');
          if (check) {
            Navigator.pushReplacementNamed(context, homePageRoute);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(showSnackbar('failed', size));
          }
        }
      },
      width: size.width,
    );
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
      },
    );
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
