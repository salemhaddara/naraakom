import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:naraakom/core/utils/Models/Message.dart';

class Conversation {
  String last_message;
  ConsultantModel consultant;
  DateTime lastUse;
  String UserId;
  List<Message> messages;
  Conversation(
      {required this.last_message,
      required this.consultant,
      required this.UserId,
      required this.lastUse,
      required this.messages});
}
