// ignore_for_file: file_names, camel_case_types

abstract class notificationeventState {}

class initialStatus extends notificationeventState {}

class fetchingNotificationsINPROGRESS extends notificationeventState {}

class fetchingNotificationsDONE extends notificationeventState {}

class fetchingNotificationsFAILED extends notificationeventState {}
