class Message {
  String messagetext, messagesenderId, messagereceiverId;
  DateTime messageTime;
  bool isReaded;
  Message(
      {required this.messagetext,
      required this.messagesenderId,
      required this.messagereceiverId,
      required this.messageTime,
      required this.isReaded});
}
