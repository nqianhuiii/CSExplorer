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

      postDetailsToFirestore(name, email, role);

      User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  postDetailsToFirestore(String username, String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref
        .doc(user!.uid)
        .set({'username': username, 'email': email, 'role': role});
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
}
