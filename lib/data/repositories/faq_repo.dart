import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:csexplorer/data/model/faq.dart';

class FaqRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Faq>> getFaqs() async {
    try {
      final querySnapshot = await _firestore.collection('faq').get();
      return querySnapshot.docs.map((doc) {
        return Faq.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting FAQs: $e');
      }
      return [];
    }
  }

  Future<bool> addFaq(Faq faq) async {
    try {
      await _firestore.collection('faq').add(faq.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error adding FAQ: $e');
      }
      return false;
    }
  }

  Future<bool> editFaq(String faqId, Faq editedFaq) async {
    try {
      await _firestore.collection('faq').doc(faqId).update(editedFaq.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error editing FAQ: $e');
      }
      return false;
    }
  }

  Future<bool> deleteFaq(String faqId) async {
    try {
      await _firestore.collection('faq').doc(faqId).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting FAQ: $e');
      }
      return false;
    }
  }
}
