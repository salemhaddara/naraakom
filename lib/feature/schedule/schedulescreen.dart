import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/Schedule.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/schedule/scheduleComponents/appointmentContainer.dart';
import 'package:naraakom/feature/schedule/scheduleComponents/choiceContainer.dart';

class schedulescreen extends StatefulWidget {
  const schedulescreen({super.key});

  @override
  State<schedulescreen> createState() => _schedulescreenState();
}

class _schedulescreenState extends State<schedulescreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: white,
      body: Directionality(
        textDirection:
            defaultLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            _buildHomeTopBar(size),
            _choiceContainer(),
            _SchedulelistView(size)
          ],
        ),
      ),
    );
  }

  Widget _SchedulelistView(Size size) {
    return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: 3,
            itemBuilder: (context, index) {
              return appointmentContainer(
                schedule: Schedule(
                  consultant: ConsultantModel(
                      name: 'Salem Haddara',
                      category: 'Family Consulting',
                      availability: '8 AM to 10 PM',
                      rating: 5,
                      id: 'id4',
                      consultation_rate: 250,
                      visitors: 1000,
                      biography: 'later',
                      experience: 5,
                      specializations: [],
                      bookings: []),
                  status: 'confirmed',
                  scheduleConsultingType: '',
                  scheduleTime: DateTime.now(),
                ),
                onJoinClicked: () {},
                onCancelClicked: () {},
                size: size,
              );
            }));
  }

  Widget _choiceContainer() {
    return ChoiceContainer(onChoiceSelected: (choice) {});
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
                  text: 'My Schedule', fontsize: 22, color: white),
            )
          ],
        ),
      ),
    );
  }
}
