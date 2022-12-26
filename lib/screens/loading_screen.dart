import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/screens/email_verify_screen.dart';
import 'package:ieee_forms/screens/login_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('wrong'),
            );
          } else if (snapshot.hasData) {
            debugPrint("LoadingScreen");
            return const EmailVerifyScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
