import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexplorer/data/model/scholarship.dart';
import 'package:flutter/foundation.dart';

class ScholarshipRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addScholarship(Scholarship scholarship) async {
    try {
      await _firestore.collection('Scholarship').add(scholarship.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting scholarship infomation: $e');
      }
    }
  }

  Future<List<Scholarship>> fetchScholarList() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Scholarship').get();
      List<Scholarship> scholarList = querySnapshot.docs.map((doc) {
        return Scholarship.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return scholarList;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching scholarship list: $e');
      }
      rethrow;
    }
  }
}
