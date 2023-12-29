import 'package:cloud_firestore/cloud_firestore.dart';

class University {
  late String id;
  late String name, location, description, background;
  late List<String> courseNames;
  late int imageIndex;

  University({
    required this.name,
    required this.location,
    required this.description,
    required this.background,
    List<String>? courseNames,
  }) : this.courseNames = courseNames ?? <String>[];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'background': background,
      'courseNames': courseNames,
    };
  }

  University.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        location = json['location'],
        description = json['description'],
        background = json['background'], // Default or handle null
        courseNames = List<String>.from(json['courseNames'] ?? []);

  University.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = snapshot['name'],
        location = snapshot['location'],
        description = snapshot['description'],
        background = snapshot['background'],// Default or handle null
        courseNames = List<String>.from(snapshot['courseNames'] ?? []);
}
