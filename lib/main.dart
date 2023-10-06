import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authrepository.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/widgets/MyNavigationBar.dart';
import 'package:naraakom/feature/chooseLang/chooseLangScreen.dart';
import 'package:naraakom/feature/login/login.dart';
import 'package:naraakom/feature/mainbloc/Repository/repository.dart';
import 'package:naraakom/feature/resetpassword/otpverification.dart';
import 'package:naraakom/feature/schedulebloc/scheduleRepo.dart';
import 'package:naraakom/feature/signup/signup.dart';
import 'package:naraakom/feature/splash/splash.dart';

void main() {
  runApp(MaterialApp(
    home: const splash(),
    debugShowCheckedModeBanner: false,
    routes: {
      chooselangRoute: (context) => const chooseLangScreen(),
      loginRoute: (context) => RepositoryProvider(
          create: (context) => authrepository(), child: const login()),
      signupRoute: (context) => RepositoryProvider(
          create: (context) => authrepository(), child: const signup()),
      otpverificationRoute: (context) => RepositoryProvider(
            create: (context) => authrepository(),
            child: const otpverification(),
          ),
      homePageRoute: (context) => MultiRepositoryProvider(
            providers: [
              RepositoryProvider(create: (context) => Repository()),
              RepositoryProvider(create: (context) => scheduleRepo()),
            ],
            child: MyNavigationBar(
              index: 0,
            ),
          ),
    },
  ));
}
