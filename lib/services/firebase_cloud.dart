import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:ieee_forms/services/questions.dart';
import 'package:ieee_forms/services/user.dart';
import 'package:flutter/material.dart';

class FirebaseCloudService {

  Future<void> addCollaborator() async {

  }

  Future<void> createUserinDB(String email, String username, String uid) async {
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'name': username,
      'forms': [],
      'uid': uid,
      'profileImg': 0
    });
  }

  Future<String> createNewForm(String formTitle, String timeStamp, String description, String submitDescription) async {
    FormQuestions questions = FormQuestions();
    String formUuid = uuid.v4();
    await FirebaseFirestore.instance.collection('forms').doc(formUuid).set({
      'acceptingResponses': true,
      'createdAt': timeStamp,
      'creatorId': MyUser.currentUser.uid,
      'id': formUuid,
      'questions': [questions.defaultTextTypeQuestion],
      'title': formTitle,
      'collaborators': [],
      'description': description,
      'submit': submitDescription
    });

    await FirebaseFirestore.instance
        .collection('responses')
        .doc(formUuid)
        .set({'responses': []});

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

    await FirebaseFirestore.instance
        .collection('responses')
        .doc(formId)
        .delete();
  }

  Future<void> updateCurrentForm(FormData form) async {
    await FirebaseFirestore.instance
        .collection('forms')
        .doc(form.formId)
        .update({'questions': form.questions, 'title': form.formTitle});
  }

  Future<FormData> getFormData(String formID) async {
    String formTitle = "";
    String createdAt = "";
    bool accRes = false;
    List questions = [];
    String description = '';
    String submitDescription = "";
    List collaborators = [];

    await FirebaseFirestore.instance
        .collection('forms')
        .doc(formID)
        .get()
        .then((DocumentSnapshot doc) {
      formTitle = doc['title'];
      createdAt = doc['createdAt'];
      accRes = doc['acceptingResponses'];
      questions = doc['questions'];
      submitDescription = doc['submit'];
      description = doc['description'];
      collaborators = doc['collaborators'];
    });

    FormData form = FormData(
        formTitle: formTitle,
        formId: formID,
        createdAt: createdAt,
        acceptingResponses: accRes,
        questions: questions,
        description: description,
        collaborators: collaborators,
        submitDescription: submitDescription
    );
    return form;
  }

  Future<void> toggleAcceptingResponses(
      String formID, bool currentState) async {
    FirebaseFirestore.instance
        .collection('forms')
        .doc(formID)
        .update({'acceptingResponses': !currentState});
  }
}
