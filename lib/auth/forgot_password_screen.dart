import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/firebase_service.dart';

class password extends StatefulWidget {
  const password({super.key});

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  final emailController = TextEditingController();
   final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset password'),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
                child: Text(
                  'Receive an email to reset your password',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'E-mail',
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: ElevatedButton.icon(
                          onPressed: (() {
                            auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                            // Utils().toastMessage(
                            //      'we have send you an E-mail to recover password,please check your e-mail');
                            // }).onError((error, stackTrace) {
                             // Utils().toastMessage(error.toString());
                             });
                          }),
                          icon: Icon(Icons.email),
                          label: Text('Reset password')),
                    ),
                  ],
                ),
              )
            ])));
  }
}


