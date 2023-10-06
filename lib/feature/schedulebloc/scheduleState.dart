import 'package:naraakom/core/utils/Models/Schedule.dart';
import 'package:naraakom/feature/schedulebloc/scheduleEvent.dart';

class scheduleState {
  List<Schedule>? confirmedSchedules = List.empty(growable: true);
  List<Schedule>? canceledSchedules = List.empty(growable: true);
  List<Schedule>? completedSchedules = List.empty(growable: true);
  SchedulesEvent? CurrentScheduleState;
  scheduleState(
      {this.confirmedSchedules,
      this.canceledSchedules,
      this.completedSchedules,
      this.CurrentScheduleState});

  scheduleState copyWith(
      {List<Schedule>? confirmedSchedules,
      List<Schedule>? canceledSchedules,
      List<Schedule>? completedSchedules,
      SchedulesEvent? CurrentScheduleState}) {
    return scheduleState(
        confirmedSchedules: confirmedSchedules ?? this.confirmedSchedules,
        canceledSchedules: canceledSchedules ?? this.canceledSchedules,
        completedSchedules: completedSchedules ?? this.completedSchedules,
        CurrentScheduleState:
            CurrentScheduleState ?? this.CurrentScheduleState);
  }
}
