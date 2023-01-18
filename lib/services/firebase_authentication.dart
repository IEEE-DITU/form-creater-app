import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/firebase_cloud.dart';

class FirebaseAuthService {
  FirebaseCloudService fireCloud = FirebaseCloudService();

  Future<bool> signupNewUser(
      String email, String password, String username) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      debugPrint(FirebaseAuth.instance.currentUser!.uid.toString());
      fireCloud.createUserinDB(
          email, username, FirebaseAuth.instance.currentUser!.uid);
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
