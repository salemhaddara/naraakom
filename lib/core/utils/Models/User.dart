import 'package:naraakom/core/utils/Models/NotificationModel.dart';

class User {
  String username, id, email, password;
  List<NotificationModel> notifications;
  User(
      {required this.username,
      required this.id,
      required this.email,
      required this.password,
      required this.notifications});
}
