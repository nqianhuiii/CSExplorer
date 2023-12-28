class Scholarship {
  late String name, description, requirement;
  late int imageIndex;

  Scholarship(this.name, this.description, this.requirement);

  Scholarship.copy(Scholarship item)
      : this(item.name, item.description, item.requirement);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'requirement': requirement
    };
  }

  Scholarship.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    requirement = json['requirement'];
    imageIndex = json['imageIndex'];
  }
}
