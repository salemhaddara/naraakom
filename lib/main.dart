import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/authRepository.dart';
import 'package:naraakom/config/theme/routes.dart';
import 'package:naraakom/core/widgets/MyNavigationBar.dart';
import 'package:naraakom/feature/booking/Repository/bookingappointmentRepo.dart';
import 'package:naraakom/feature/chooseLang/chooseLangScreen.dart';
import 'package:naraakom/feature/login/login.dart';
import 'package:naraakom/feature/mainbloc/Repository/repository.dart';
import 'package:naraakom/feature/notifications/Repo/notificationsRepo.dart';
import 'package:naraakom/feature/resetpassword/otpverification.dart';
import 'package:naraakom/feature/resetpassword/setnewpass.dart';
import 'package:naraakom/feature/schedulebloc/scheduleRepo.dart';
import 'package:naraakom/feature/signup/signup.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => Repository()),
        RepositoryProvider(create: (context) => scheduleRepo()),
        RepositoryProvider(create: (context) => authRepository()),
        RepositoryProvider(create: (context) => bookingappointmentRepo()),
        RepositoryProvider(create: (context) => notificationsRepo()),
      ],
      child: MaterialApp(
        home: const splash(),
        debugShowCheckedModeBanner: false,
        routes: {
          chooselangRoute: (context) => const chooseLangScreen(),
          loginRoute: (context) => const login(),
          signupRoute: (context) => const signup(),
          otpverificationRoute: (context) => const otpverification(),
          homePageRoute: (context) => MyNavigationBar(
                index: 0,
              ),
          setnewpassRoute: (context) => const setnewpass()
        },
      )));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
