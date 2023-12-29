class Reply
{
  String reply;
  int likes;

  Reply(this.reply, this.likes);

  Reply.copy(Reply item) : this(item.reply, item.likes);

  Map<String, dynamic> toJson() {
    return {
      'reply': reply,
      'likes': likes,
    };
  }

  Reply.fromJson(Map<String, dynamic> json)
      : reply = json['reply'] ?? '',
        likes = json['likes'] ?? 0;
}


