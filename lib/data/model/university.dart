class University {
  late String name, location, description, background;
  late List<String> courseNames;
  late int imageIndex;

  University(
    this.name,
    this.location,
    this.description,
    this.background, {
    List<String>? courseNames,
  }) : courseNames = courseNames ?? <String>[];

  University.copy(University item)
      : this(item.name, item.location, item.description, item.background,
            courseNames: List<String>.from(item.courseNames));

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'background': background,
      'courseNames': courseNames,
    };
  }

  University.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    description = json['description'];
    background = json['background'];
    imageIndex = json['imageIndex'];
    courseNames = List<String>.from(json['courseNames'] ?? []);
  }
}
