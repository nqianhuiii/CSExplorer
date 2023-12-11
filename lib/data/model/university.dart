class University {
  late String description, location;

  University(this.description, this.location);

  University.copy(University item) : this(item.description, item.location);

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'location': location,
    };
  }

  University.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    location = json['location'];
  }
}
