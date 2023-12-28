// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/topBar.dart';
import 'package:naraakom/feature/questions/Repo/questionsRepo.dart';
import 'package:naraakom/feature/questions/Widgets/questionItem.dart';
import 'package:naraakom/feature/questions/states/questions_bloc.dart';
import 'package:naraakom/feature/questions/states/questions_event.dart';
import 'package:naraakom/feature/questions/states/questions_state.dart';
import 'package:naraakom/feature/splash/splash.dart';

class questionsScreen extends StatefulWidget {
  const questionsScreen({super.key});

  @override
  State<questionsScreen> createState() => _questionsScreenState();
}

class _questionsScreenState extends State<questionsScreen> {
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
          create: (context) => questions_bloc(context.read<questionsRepo>())
            ..add(questionFetchRequest()),
          child: SafeArea(
            child: Directionality(
              textDirection:
                  defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: Column(
                children: [
                  topBar(size: size, textResourceId: 'Privacy Policy'),
                  _listView(size),
                ],
              ),
            ),
          )),
    );
  }

  _listView(Size size) {
    return BlocBuilder<questions_bloc, questions_state>(
        builder: (context, state) {
      if (state.allQuestions != null && state.allQuestions!.isNotEmpty) {
        return Expanded(
          child: ListView.builder(
              itemCount: state.allQuestions!.length,
              itemBuilder: (context, index) {
                return questionItem(
                    size: size, question: state.allQuestions![index]);
              }),
        );
      }
      return Container();
    });
  }
}
