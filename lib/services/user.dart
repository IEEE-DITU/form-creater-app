import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyUser {
  late String email;
  late String name;
  late String uid = "";
  late List forms;
  late String profileImg;

  static MyUser currentUser = MyUser();

  static Future<void> getCurrentUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        currentUser.name = doc['name'];
        currentUser.uid = doc['uid'];
        currentUser.email = doc['email'];
        currentUser.forms = doc['forms'];
        currentUser.profileImg = doc['profileImg'];
        debugPrint(currentUser.forms.length.toString());
      }
    });
  }
}
