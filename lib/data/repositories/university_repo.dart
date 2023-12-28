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



  Future<List<University>> fetchUniList() async {
    try {
      final querySnapshot = await _firestore.collection('University').get();
      return querySnapshot.docs.map((doc) {
        return University.fromSnapshot(doc);
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting university: $e');
      }
      return [];
    }
  }



  
 Future<bool> editUniversity(String universityId, University editedUniversity) async {
    try {
      await _firestore.collection('University').doc(universityId).update(editedUniversity.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error editing University: $e');
      }
      return false;
    }
  }

}
