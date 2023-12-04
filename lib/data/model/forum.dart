class Forum {
  late String subject, message;

  Forum(this.subject, this.message);

  Forum.copy(Forum item) : this(item.subject, item.message);

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'message': message,
    };
  }

  Forum.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    message = json['message'];
  }
}
