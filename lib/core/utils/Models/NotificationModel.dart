class NotificationModel {
  String senderName, notificationtext, notificationtime, senderprofileURL;
  bool isRead;
  NotificationModel(
      {required this.senderName,
      required this.notificationtext,
      required this.notificationtime,
      required this.senderprofileURL,
      required this.isRead});
}
