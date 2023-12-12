class University {
  late String name, description;
  late int imageIndex;

  University(this.name, this.description);

  University.copy(University item) : this(item.name, item.description);

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }

  University.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    imageIndex = json['imageIndex'];
  }
}
