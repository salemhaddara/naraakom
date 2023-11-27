import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/Schedule.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/schedule/scheduleComponents/appointmentContainer.dart';
import 'package:naraakom/feature/schedule/scheduleComponents/choiceContainer.dart';
import 'package:naraakom/feature/schedulebloc/scheduleEvent.dart';
import 'package:naraakom/feature/schedulebloc/scheduleRepo.dart';
import 'package:naraakom/feature/schedulebloc/scheduleState.dart';
import 'package:naraakom/feature/schedulebloc/schedulebloc.dart';

class schedulescreen extends StatefulWidget {
  const schedulescreen({super.key});

  @override
  State<schedulescreen> createState() => _schedulescreenState();
}

class _schedulescreenState extends State<schedulescreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    return BlocProvider<schedulebloc>(
        create: (context) => schedulebloc(context.read<scheduleRepo>())
          ..add(UpComingSchedulesRequested()),
        child: Scaffold(
          backgroundColor: white,
          body: Directionality(
            textDirection:
                defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                _buildHomeTopBar(size),
                _choiceContainer(size),
                _SetListofSchedule(size)
              ],
            ),
          ),
        ));
  }

  Widget _SetListofSchedule(Size size) {
    return BlocBuilder<schedulebloc, scheduleState>(
      builder: (context, state) {
        if (state.CurrentScheduleState is UpComingSchedulesRequested &&
            state.confirmedSchedules != null) {
          return _SchedulelistView(size, state.confirmedSchedules!);
        }
        if (state.CurrentScheduleState is CanceledSchedulesRequested &&
            state.canceledSchedules != null) {
          return _SchedulelistView(size, state.canceledSchedules!);
        }
        if (state.CurrentScheduleState is CompletedSchedulesRequested &&
            state.completedSchedules != null) {
          return _SchedulelistView(size, state.completedSchedules!);
        }

        return Container();
      },
    );
  }

  Widget _SchedulelistView(Size size, List<Schedule> schedules) {
    return Expanded(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              return appointmentContainer(
                schedule: schedules[index],
                onJoinClicked: () {},
                onCancelClicked: () {},
                size: size,
              );
            }));
  }

  Widget _choiceContainer(Size size) {
    return BlocBuilder<schedulebloc, scheduleState>(builder: (context, state) {
      return ChoiceContainer(onChoiceSelected: (choice) {
        switch (choice) {
          case 'Upcoming':
            return context
                .read<schedulebloc>()
                .add(UpComingSchedulesRequested());

          case 'Completed':
            return context
                .read<schedulebloc>()
                .add(CompletedSchedulesRequested());

          case 'Canceled':
            return context
                .read<schedulebloc>()
                .add(CanceledSchedulesRequested());
        }
      });
    });
  }

  Widget _buildHomeTopBar(Size size) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      width: size.width,
      height: size.height * 0.15,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bar.png',
              width: size.width,
              height: size.height * 0.20,
              fit: BoxFit.cover,
            ),
            Container(
              margin:
                  EdgeInsets.only(top: size.height * 0.08, left: 16, right: 16),
              child: text700normal(
                  text: language[defaultLang]['myschedule'],
                  fontsize: 22,
                  color: white),
            )
          ],
        ),
      ),
    );
  }
}
