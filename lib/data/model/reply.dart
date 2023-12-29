class Reply {
  String reply;
  int likes;
  String name;
  String id;

  Reply(this.reply, this.likes, this.name,this.id);

  Reply.copy(Reply item) : this(item.reply, item.likes, item.name,item.id);

  Map<String, dynamic> toJson() {
    return {
      'reply': reply,
      'likes': likes,
      'name': name,
      'id':id,
    };
  }

  Reply.fromJson(Map<String, dynamic> json)
      : reply = json['reply'] ?? '',
        likes = json['likes'] ?? 0,
        name = json['name'] ?? '',
        id = json['id'] ?? '';
  


}
