import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String email = "";

  @override
  void initState() {
    email = widget.email;
    super.initState();
  }

  void navigateLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
            onPressed: () => navigateLogin(),
          ),
        ),
        body: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 70.0,
              ),
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter your Registered Email',
                ),
                initialValue: email,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (email != '' && EmailValidator.validate(email)) {
                    return null;
                  }
                  return 'Invalid Email';
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: customButton(context, 'Get link on email', () {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reset link sent on the email')));
                  navigateLogin();
                }),
              ),
            ])));
  }
}
