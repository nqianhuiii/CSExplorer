import 'package:cloud_firestore/cloud_firestore.dart';

class Course{
  late String id;
  late String name, description, academicRequirements, jobOpportunity;
  late int imageIndex;

  Course({
    required this.name,
    required this.description,
    required this.academicRequirements,
    required this.jobOpportunity,
  }); 

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'background': academicRequirements,
      'courseNames': jobOpportunity,
    };
  }

  Course.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        academicRequirements = json['academicRequirements'],
        jobOpportunity= json['jobOpportunity'],
        imageIndex = json['imageIndex'] ?? 0; 
        

  Course.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = snapshot['name'],
        description = snapshot['description'],
        academicRequirements = snapshot['academicRequirements'],
        jobOpportunity= snapshot['jobOpportunity'],
        imageIndex = snapshot['imageIndex'] ?? 0;
}