import 'package:cloud_firestore/cloud_firestore.dart';

class AuthStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String userId, String email, String role) async {
    await _firestore.collection('users').doc(userId).set({
      'email': email,
      'role': role,
    });
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userId).get();
    return snapshot.data() as Map<String, dynamic>?;
  }
}
