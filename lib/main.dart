import 'package:flutter/material.dart';
import 'package:ieee_forms/Signin.dart';
import 'package:ieee_forms/Signup.dart';
void main() {
  runApp( const Loginpage());
}
class  Loginpage extends StatelessWidget {
  const Loginpage({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MY LOGIN PAGE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
           "/":(context) => const MySignup(),
        }
        );
  }
}