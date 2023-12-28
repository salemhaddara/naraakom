// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/Snackbar.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/feature/termsandConditions/Repo/termsAndConditionsRepo.dart';
import 'package:naraakom/feature/termsandConditions/States/termsAndconditions_State.dart';
import 'package:naraakom/feature/termsandConditions/States/termsAndconditions_bloc.dart';
import 'package:naraakom/feature/termsandConditions/States/termsAndconditions_event.dart';
import 'package:naraakom/feature/termsandConditions/Tracker/termsRequestTracker.dart';

class termsandconditionsScreen extends StatefulWidget {
  const termsandconditionsScreen({super.key});

  @override
  State<termsandconditionsScreen> createState() =>
      _termsandconditionsScreenState();
}

class _termsandconditionsScreenState extends State<termsandconditionsScreen> {
  bool showedException = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            termsAndconditions_bloc(context.read<termsAndConditionsRepo>())
              ..add(request_termsAndconditions()),
        child: SafeArea(
          child: BlocBuilder<termsAndconditions_bloc, termsAndconditions_State>(
              builder: (context, state) {
            if (state.tracker is termsRequestFailed) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(showSnackbar(
                    (state.tracker as termsRequestFailed).exception, size));
              });
              showedException = true;
            }
            return Directionality(
              textDirection:
                  defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: Column(
                children: [
                  _topBar(size),
                  _devider(),
                  if (state.tracker is termsRequestSuccess)
                    Column(
                      children: [
                        _termsAndConditionstitleWithDate(
                            size, '${state.lastUpdate}'),
                        _devider(height: 5),
                        _termsOfUseText(state.termsAndconditions_TEXT ?? '')
                      ],
                    ),
                  if (state.tracker is termsRequestLoading)
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        color: cyan,
                      ),
                    ))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  _termsAndConditionstitleWithDate(Size size, String time) {
    return Container(
      height: 100,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              'assets/images/termsandconditions.svg',
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Expanded(
                      child: text700normal(
                    fontsize: 18,
                    color: darkblack,
                    text: language[defaultLang]['termofservice'],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: text400normal(
                    fontsize: 14,
                    color: grey,
                    text: '${language[defaultLang]['updated']} : $time',
                  )),
                  const Spacer()
                ],
              ))
        ],
      ),
    );
  }

  _termsOfUseText(String text) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: text400normal(
        text: text,
        color: darkblack,
        fontsize: 14,
        align: TextAlign.center,
      ),
    );
  }

  _devider({double? height}) {
    return Container(
      height: height ?? 10,
      color: homebackgrey,
      margin: const EdgeInsets.only(top: 5),
    );
  }

  _topBar(Size size) {
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
              text: '${language[defaultLang]['Terms of use']}',
              fontsize: 20,
              color: lightblack,
            ),
          )
        ]),
      ),
    );
  }
}
