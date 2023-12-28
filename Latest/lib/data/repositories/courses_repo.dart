import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexplorer/data/model/courses.dart';
import 'package:flutter/foundation.dart';

class CoursesRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCourses(Courses courses) async {
    try {
      await _firestore.collection('Courses').add(courses.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting courses infomation: $e');
      }
    }
  }

  Future<List<Courses>> fetchCoursesList() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Courses').get();
      List<Courses> coursesList = querySnapshot.docs.map((doc) {
        return Courses.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return coursesList;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching courses list: $e');
      }
      rethrow;
    }
  }
}
