// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/topBar.dart';
import 'package:naraakom/feature/personalDetails/Repo/personalDetailsRepo.dart';
import 'package:naraakom/feature/personalDetails/Widgets/ProfileCard.dart';
import 'package:naraakom/feature/personalDetails/states/personalDetails_bloc.dart';
import 'package:naraakom/feature/personalDetails/states/personalDetails_event.dart';
import 'package:naraakom/feature/personalDetails/states/personalDetails_state.dart';
import 'package:naraakom/feature/splash/splash.dart';

class personalDetails extends StatefulWidget {
  const personalDetails({super.key});

  @override
  State<personalDetails> createState() => _personalDetailsState();
}

class _personalDetailsState extends State<personalDetails> {
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
              personalDetails_bloc(context.read<personalDetailsRepo>())
                ..add(fetchDetails()),
          child: SafeArea(
            child: Directionality(
              textDirection:
                  defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: Column(
                children: [
                  topBar(
                    size: size,
                    textResourceId: 'Profile',
                    backColor: cyan,
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      Container(
                        height: size.height / 3,
                        color: cyan,
                      ),
                      _detailsCard(size)
                    ],
                  ))
                ],
              ),
            ),
          )),
    );
  }

  _detailsCard(Size size) {
    return BlocBuilder<personalDetails_bloc, personalDetails_state>(
        builder: (context, state) {
      return profileCard(
        username: state.userName ?? '',
        phoneNumber: state.phoneNumber ?? '',
        emailAddress: state.emailAddress ?? '',
        password: state.password ?? '',
      );
    });
  }
}
