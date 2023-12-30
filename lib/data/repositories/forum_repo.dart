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

  Future<void> deleteForumTopic(Forum forum) async
  {
    try {
      await _firestore.collection('Forum').doc(forum.id).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting forum topic: $e');
      }
    }
  }

  Future<void> deleteForumTopicBySubject(String subject) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there is only one document with the given subject
        String documentId = querySnapshot.docs.first.id;
        await _firestore.collection('Forum').doc(documentId).delete();
      } else {
        if (kDebugMode) {
          print('No forum topic found with subject: $subject');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting forum topic: $e');
      }
    }
  }



  Future<List<Forum>> fetchForumList() async
  {
    try
    {
      QuerySnapshot querySnapshot = await _firestore.collection('Forum').get();
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

  static Future<void> deleteReply(String subject, String replyId) async
  {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        await repliesCollection.doc(replyId).delete();
      }
      else
      {
        // ignore: avoid_print
        print('Subject not found: $subject');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting reply: $e');
      rethrow;
    }
  }

  static Future<void> editReply(
      String subject, String replyId, String newReply) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        await repliesCollection.doc(replyId).update({'reply': newReply});
      }
      else
      {
        // ignore: avoid_print
        print('Subject not found: $subject');
      }
    }
    catch (e)
    {
      // ignore: avoid_print
      print('Error editing reply: $e');
      rethrow;
    }
  }

  Future<List<String>> getAllReplyUserIds(String subject) async {
    try {

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Replies')
              .get();

      List<String> userIds = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              doc['id'] as String)
          .toList();

      return userIds;
    } catch (error) {
      print('Error retrieving reply user IDs: $error');
      return [];
    }
  }


static Future<String> getIdForReply(String subject, String name) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        QuerySnapshot replyQuery = await subjectRef
            .collection('Replies')
            .where('name', isEqualTo: name)
            .limit(1)
            .get();

        if (replyQuery.docs.isNotEmpty) {
          return replyQuery.docs.first.id;
        } else {
          // ignore: avoid_print
          print('Reply not found for name: $name');
          return '';
        }
      } else {
        // ignore: avoid_print
        print('Subject not found: $subject');
        return '';
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error retrieving id for reply: $e');
      rethrow;
    }
  }




 static Future<String> addReplyToSubject(String subject, String reply,String name,String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        DocumentReference replyDocRef =
            await repliesCollection.add({'reply': reply, 'likes': 0,'name':name,'id':id});

        return replyDocRef.id;
      } else {
        // ignore: avoid_print
        print('Subject not found: $subject');
        return '';
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error adding reply to subject: $e');
      rethrow;
    }
  }

 static Future<List<String>> retrieveNamesForSubject(String subject) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        QuerySnapshot repliesQuery = await repliesCollection.get();
        List<String> namesList = [];

        for (QueryDocumentSnapshot replyDoc in repliesQuery.docs) {
          String? name = replyDoc['name'] as String?;
          if (name != null) {
            namesList.add(name);
          }
        }

        return namesList;
      } else {
        // ignore: avoid_print
        print('Subject not found: $subject');
        return [];
      }
    }
    catch (e)
    {
      // ignore: avoid_print
      print('Error retrieving names for subject: $e');
      rethrow;
    }
  }


  static Future<List<String>> retrieveIdsForSubject(String subject) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        QuerySnapshot repliesQuery = await repliesCollection.get();
        List<String> idsList = [];

        for (QueryDocumentSnapshot replyDoc in repliesQuery.docs) {
          String? id = replyDoc['id'] as String?;
          if (id != null) {
            idsList.add(id);
          }
        }

        return idsList;
      } else {
        // Subject not found
        print('Subject not found: $subject');
        return [];
      }
    } catch (e) {
      // Error handling
      print('Error retrieving IDs for subject: $e');
      rethrow;
    }
  }





  static Future<List<String>> retrieveRepliesForSubject(String subject) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

       QuerySnapshot repliesQuery = await repliesCollection.get();
        List<String> repliesList = repliesQuery.docs
            .map((doc) => doc['reply'] as String?)
            .where((reply) => reply != null)
            .map((reply) => reply!)
            .toList();

        return repliesList;
      } else {
        // ignore: avoid_print
        print('Subject not found: $subject');
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error retrieving replies for subject: $e');
      rethrow;
    }
  }

   Future<void> incrementLikeForum(String forum) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: forum)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await firestore.collection('Forum').doc(document.id).update({
          'likes': FieldValue.increment(1),
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getLikesForum(String comment) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: comment)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot document = querySnapshot.docs.first;
        int likes = document['likes'] ?? 0;
        return likes;
      } else {
        return 0;
      }
    } catch (e) {
      rethrow;
    }
  }

   static Future<void> incrementLikesForReply(
      String subject, String replyId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        DocumentReference replyRef = repliesCollection.doc(replyId);

        await replyRef.update({'likes': FieldValue.increment(1)});
      } else {
        // ignore: avoid_print
        print('Subject not found: $subject');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error incrementing likes for reply: $e');
      rethrow;
    }
  }

  static Future<List<String>> getAllReplyIdsForSubject(String subject) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        QuerySnapshot repliesQuery = await repliesCollection.get();

        List<String> replyIds = repliesQuery.docs
            .map((doc) => doc.id)
            // ignore: unnecessary_null_comparison
            .where((id) => id != null)
            // ignore: unnecessary_cast
            .map((id) => id as String)
            .toList();

        return replyIds;
      } else {
        // ignore: avoid_print
        print('Subject not found: $subject');
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching reply ids for subject: $e');
      rethrow;
    }
  }

 Future<int> retrieveLikesForReply(
      String subject, String replyId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot subjectQuery = await firestore
          .collection('Forum')
          .where('subject', isEqualTo: subject)
          .limit(1)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        DocumentReference subjectRef = subjectQuery.docs.first.reference;
        CollectionReference repliesCollection =
            subjectRef.collection('Replies');

        DocumentSnapshot replySnapshot =
            await repliesCollection.doc(replyId).get();

        if (replySnapshot.exists) {
          final Map<String, dynamic>? data =
              replySnapshot.data() as Map<String, dynamic>?;

          if (data != null &&
              data.containsKey('likes') &&
              data['likes'] is int) {
            return data['likes'] as int;
          }
        } else {

          // ignore: avoid_print
          print('Reply not found: $replyId');
        }
      }
      else {
        // ignore: avoid_print
        print('Subject not found: $subject');
      }
      return 0;
    }
    catch (e) {
      // ignore: avoid_print
      print('Error retrieving likes for reply: $e');
      return 0;
    }
  }



}
