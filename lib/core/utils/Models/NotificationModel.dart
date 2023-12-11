// ignore_for_file: non_constant_identifier_names

class NotificationModel {
  int user_id;
  String title, content, created, photo, link;
  int read;

  NotificationModel(
      {required this.user_id,
      required this.title,
      required this.content,
      required this.created,
      required this.photo,
      required this.link,
      required this.read});

  static bool hasUnreadNotification(List<NotificationModel> notifications) {
    for (var notification in notifications) {
      if (notification.read != 0) {
        return true;
      }
    }
    return false;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      user_id: json['user_id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      created: json['created_at'] ?? '',
      photo: json['photo'] ?? '',
      link: json['link'] ?? '',
      read: json['read'] ?? 0,
    );
  }

  static List<NotificationModel> parseNotifications(
      Map<String, dynamic> jsonData) {
    if (jsonData.containsKey('data') && jsonData['data'] is List) {
      var notificationList = <NotificationModel>[];
      for (var notificationData in jsonData['data']) {
        notificationList.add(NotificationModel.fromJson(notificationData));
      }
      return notificationList;
    } else {
      return [];
    }
  }

  static List<NotificationModel> getEarlierNotifications(
      List<NotificationModel> notifications) {
    DateTime now = DateTime.now(); // Get the current date/time

    List<NotificationModel> earlierNotifications =
        notifications.where((notification) {
      DateTime notificationDate = DateTime.parse(notification.created);
      return !(notificationDate.year == now.year &&
          notificationDate.month == now.month &&
          notificationDate.day == now.day);
    }).toList();

    // Sort earlier notifications in descending order (latest to oldest) based on creation date
    earlierNotifications.sort((a, b) =>
        DateTime.parse(b.created).compareTo(DateTime.parse(a.created)));

    return earlierNotifications;
  }

  static List<NotificationModel> getTodayNotifications(
      List<NotificationModel> notifications) {
    DateTime now = DateTime.now(); // Get the current date/time

    List<NotificationModel> todayNotifications =
        notifications.where((notification) {
      DateTime notificationDate = DateTime.parse(notification.created);
      return notificationDate.year == now.year &&
          notificationDate.month == now.month &&
          notificationDate.day == now.day;
    }).toList();

    // Sort today's notifications in descending order (latest to oldest) based on creation date
    todayNotifications.sort((a, b) =>
        DateTime.parse(b.created).compareTo(DateTime.parse(a.created)));

    return todayNotifications;
  }
}
