class Forum {
  late String subject, message;
  late int likes=0;

  Forum(this.subject, this.message, this.likes);

  Forum.copy(Forum item) : this(item.subject, item.message, item.likes);

  Map<String, dynamic> toJson() {
    return {'subject': subject, 'message': message, 'likes': likes};
  }

  Forum.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    message = json['message'];
    likes = json['likes'];
  }
}
