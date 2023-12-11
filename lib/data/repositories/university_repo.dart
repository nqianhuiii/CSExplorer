import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexplorer/data/model/university.dart';
import 'package:flutter/foundation.dart';

class UniversityRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUniversity(University university) async {
    try {
      await _firestore.collection('University').add(university.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting university infomation: $e');
      }
    }
  }
}
