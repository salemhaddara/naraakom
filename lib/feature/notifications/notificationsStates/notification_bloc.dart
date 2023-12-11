// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naraakom/core/utils/Models/NotificationModel.dart';
import 'package:naraakom/feature/notifications/Repo/notificationsRepo.dart';
import 'package:naraakom/feature/notifications/notificationsEventsStates/notificationeventState.dart';
import 'package:naraakom/feature/notifications/notificationsStates/notification_event.dart';
import 'package:naraakom/feature/notifications/notificationsStates/notification_state.dart';

class notification_bloc extends Bloc<notification_event, notification_state> {
  notificationsRepo repo;
  notification_bloc(this.repo)
      : super(notification_state([], [], initialStatus())) {
    on<requestNotifications>(
      (event, emit) async {
        emit(state.copyWith(status: fetchingNotificationsINPROGRESS()));
        var result = await repo.getUserNotifications();

        List<NotificationModel> notifications =
            NotificationModel.parseNotifications(result);
        try {
          List<NotificationModel> todaynotifications =
              NotificationModel.getTodayNotifications(notifications);
          List<NotificationModel> earliernotifications =
              NotificationModel.getEarlierNotifications(notifications);
          emit(state.copyWith(
            todaynotifications: todaynotifications,
            earliernotifications: earliernotifications,
            status: fetchingNotificationsDONE(),
          ));
        } catch (e) {
          print(e.toString());
        }
      },
    );
  }
}
