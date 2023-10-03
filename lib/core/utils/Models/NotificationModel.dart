class NotificationModel {
  String senderName, notificationtext, notificationtime, senderprofileURL;
  bool isRead;

  NotificationModel(
      {required this.senderName,
      required this.notificationtext,
      required this.notificationtime,
      required this.senderprofileURL,
      required this.isRead});

  static bool hasUnreadNotification(List<NotificationModel> notifications) {
    for (var notification in notifications) {
      if (!notification.isRead) {
        return true;
      }
    }
    return false;
  }
}
