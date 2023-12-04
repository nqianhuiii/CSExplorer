import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexplorer/data/model/forum.dart';
import 'package:flutter/foundation.dart';

class ForumRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addForumTopic(Forum forum) async {
    try {
      await _firestore.collection('Forum').add(forum.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting forum posting: $e');
      }
    }
  }
}
