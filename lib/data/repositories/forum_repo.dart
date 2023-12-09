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

  Future<List<Forum>> fetchForumList() async {
    try {
      // fetch data from firestore
      QuerySnapshot querySnapshot = await _firestore.collection('Forum').get();
      
      // retrieve list of cdoc, transform each doc in list, convert raw data to Forum object
      List<Forum> forumList = querySnapshot.docs.map((doc) {
        return Forum.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return forumList;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching forum list: $e');
      }
      rethrow;
    }
  }
}
