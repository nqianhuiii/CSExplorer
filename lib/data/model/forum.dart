class Forum
{
  late String subject, message;
  late int likes = 0;
  late String id;
  late String name;
  late String image;

  Forum(this.subject, this.message, this.likes, this.id, this.name, this.image);

  Forum.copy(Forum item)
      : this(item.subject, item.message, item.likes, item.id, item.name,
            item.image);

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'message': message,
      'likes': likes,
      'id': id,
      'name': name,
      'image': image,
    };
  }

  Forum.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    message = json['message'];
    likes = json['likes'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}