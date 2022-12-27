import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {
  Future<bool> signupNewUser(
      String email, String password, String username) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      debugPrint(FirebaseAuth.instance.currentUser!.uid.toString());
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'email': email,
        'name': username,
        'forms': [],
        'uid': FirebaseAuth.instance.currentUser!.uid
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }
}
