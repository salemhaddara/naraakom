import 'package:naraakom/core/utils/Models/ConsultantModel.dart';

class Schedule {
  ConsultantModel consultant;
  String status, scheduleConsultingType;
  DateTime scheduleTime;
  Schedule(
      {required this.consultant,
      required this.status,
      required this.scheduleConsultingType,
      required this.scheduleTime});
}
