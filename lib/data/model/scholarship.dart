import 'package:cloud_firestore/cloud_firestore.dart';

class Scholarship {
  late String providerName;
  late String description;
  late String applicationRequirement;
  late String id;
  late String link;
  late int imageIndex;


  Scholarship({
    required this.providerName,
    required this.description,
    required this.applicationRequirement,
    required this.link,
  });

  Map<String, dynamic> toJson() {
    return {
      'providerName': providerName,
      'description': description,
      'applicationRequirement': applicationRequirement,
      'link': link,
    };
  }

  Scholarship.fromJson(Map<String, dynamic> json)
      : providerName = json['providerName'],
        description = json['description'],
        applicationRequirement= json['applicationRequirement'],
        link = json['link'],
        imageIndex = json['imageIndex'] ?? 0; 
        

  Scholarship.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        providerName = snapshot['providerName'],
        description = snapshot['description'],
        applicationRequirement = snapshot['applicationRequirement'],
        link = snapshot['link'],
        imageIndex = snapshot['imageIndex'] ?? 0;
}