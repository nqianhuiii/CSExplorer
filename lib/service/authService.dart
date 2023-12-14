// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(
      String name, String email, String password, String role) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      setUserData(name, email, role);

      User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> logIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found');
      } else if (e.code == 'wrong-password') {
        print('Invalid password');
      }
      return null;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  setUserData(String username, String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref
        .doc(user!.uid)
        .set({'username': username, 'email': email, 'role': role});
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Unseccessful password update');
    }
  }
}
