class ChatModel {
  final String id;
  final String from;
  final String to;
  final String message;
  final String isread;
  final String isdelete;
  final String idUser;
  final String time;
  final String idOffice;
  final String nameOfUser;

  ChatModel(this.id, this.from, this.to, this.message, this.isread,
      this.isdelete, this.idUser, this.time, this.idOffice, this.nameOfUser);
}

final listChat = new List<ChatModel>();