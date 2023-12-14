class University {
  late String name, location, description, background;
  late int imageIndex;

  University(this.name, this.location, this.description, this.background);

  University.copy(University item)
      : this(item.name, item.location, item.description, item.background);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'background': background
    };
  }

  University.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    description = json['description'];
    background = json['background'];
    imageIndex = json['imageIndex'];
  }
}
