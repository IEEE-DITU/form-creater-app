import 'package:firebase_auth/firebase_auth.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String formTitle = "";
  String formId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My forms'),
      ),
      body: FutureBuilder(
        future: MyUser.getCurrentUser(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else {
            return ListView.builder(
              itemCount: MyUser.currentUser.forms.length,
              itemBuilder: (context, index) {
                formId = MyUser.currentUser.forms[index];
                return FutureBuilder(
                  future: getFormData(formId),
                    builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if(snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 10)
                            ]),
                        child: Column(
                          children: [Text(snapshot.data!.formTitle), Text(snapshot.data!.formId)],
                        ),
                      );
                    }
                    return const SizedBox(height: 10,);
                });
              });
          }
        }
      ),
    );
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
}
