// ignore_for_file: camel_case_types

import 'package:naraakom/core/utils/Models/NotificationModel.dart';
import 'package:naraakom/feature/notifications/notificationsEventsStates/notificationeventState.dart';

class notification_state {
  List<NotificationModel> todaynotifications = List.empty();
  List<NotificationModel> earliernotifications = List.empty();
  notificationeventState status = initialStatus();
  notification_state(
      this.todaynotifications, this.earliernotifications, this.status);
  notification_state copyWith(
      {List<NotificationModel>? todaynotifications,
      List<NotificationModel>? earliernotifications,
      notificationeventState? status}) {
    return notification_state(
        todaynotifications ?? this.todaynotifications,
        earliernotifications ?? this.earliernotifications,
        status ?? this.status);
  }
}
