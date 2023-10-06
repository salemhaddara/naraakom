import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/feature/schedulebloc/scheduleEvent.dart';
import 'package:naraakom/feature/schedulebloc/scheduleRepo.dart';
import 'package:naraakom/feature/schedulebloc/scheduleState.dart';

class schedulebloc extends Bloc<SchedulesEvent, scheduleState> {
  final scheduleRepo repo;
  schedulebloc(this.repo) : super(scheduleState()) {
    on<UpComingSchedulesRequested>((event, emit) {
      emit(state.copyWith(
          confirmedSchedules: repo.getUpcomingSchedule(),
          CurrentScheduleState: UpComingSchedulesRequested()));
    });
    on<CanceledSchedulesRequested>((event, emit) {
      emit(state.copyWith(
          canceledSchedules: repo.getCanceledSchedule(),
          CurrentScheduleState: CanceledSchedulesRequested()));
    });
    on<CompletedSchedulesRequested>((event, emit) {
      emit(state.copyWith(
          completedSchedules: repo.getCompletedSchedule(),
          CurrentScheduleState: CompletedSchedulesRequested()));
    });
  }
}
