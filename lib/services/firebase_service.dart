import 'package:ieee_forms/services/form_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ieee_forms/services/user.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  Uuid uuid = const Uuid();

  Future<bool> signupNewUser(
      String email, String password, String username) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      debugPrint(FirebaseAuth.instance.currentUser!.uid.toString());
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
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

  Future<String> createNewForm(String formTitle, String timeStamp) async {
    String formUuid = uuid.v4();
    await FirebaseFirestore.instance.collection('forms').doc(formUuid).set({
      'acceptingResponses': true,
      'createdAt': timeStamp,
      'creatorId': MyUser.currentUser.uid,
      'id': formUuid,
      'questions': [],
      'title': formTitle
    });

    MyUser.currentUser.forms.add(formUuid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(MyUser.currentUser.uid)
        .update({'forms': MyUser.currentUser.forms});
  return formUuid;
  }

  Future<void> deleteForm(String formId) async {
    await FirebaseFirestore.instance.collection('forms').doc(formId).delete();
    MyUser.currentUser.forms.remove(formId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(MyUser.currentUser.uid)
        .update({'forms': MyUser.currentUser.forms});
  }

  Future<FormData> getFormData(String formID) async {
    String formTitle = "";
    String createdAt = "";
    bool accRes = false;
    await FirebaseFirestore.instance
        .collection('forms')
        .doc(formID)
        .get()
        .then((DocumentSnapshot doc) {
      formTitle = doc['title'];
      createdAt = doc['createdAt'];
      accRes = doc['acceptingResponses'];
    });

    FormData form = FormData(
        formTitle: formTitle,
        formId: formID,
        createdAt: createdAt,
        acceptingResponses: accRes);

    debugPrint("Finish");
    return form;
  }
  
  Future<void> toggleAcceptingResponses(String formID, bool currentState) async {
    FirebaseFirestore.instance.collection('forms').doc(formID).update(
        {'acceptingResponses': !currentState});
  }
}
