class Message {
  String? message;
  String? subMessage;

  Message();

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    subMessage = json['subMessage'];
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'subMessage': subMessage,
      };
}