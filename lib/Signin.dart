import 'dart:ui';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/Signup.dart';

class MySignin extends StatefulWidget {
  const MySignin({super.key});

  @override
  State<MySignin> createState() => _MySigninState();
}

class _MySigninState extends State<MySignin> {
  bool _ishidden = true;
  bool _ischeck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(children: [
          SizedBox(
            height: 100.0,
          ),
          Container(
            width: 500,
            child: Text(
              'Sign in',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 500,
            child: Text(" Don't have an account yet?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              width: 500,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {             
                      Navigator.push(
                          context,
                          MaterialPageRoute( builder: (context) => const MySignup()));
                    },
                    child: Text('Register here !',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20)),
                  )
                ],
              )),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                hintText: " Enter your email address",
                labelText: "Email"),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            obscureText: _ishidden,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child:
                      Icon(_ishidden ? Icons.visibility : Icons.visibility_off),
                ),
                hintText: " Enter your Password",
                labelText: "Password"),
          ),
          SizedBox(
            height: 1.0,
          ),
          Row(
            children: [
              Checkbox(
                  value: _ischeck,
                  onChanged: (val) {
                    setState(() {
                      _ischeck = val!;
                    });
                  }),
              Text(
                "Remember me",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                width: 40.0,
              ),
              TextButton(
                  onPressed: (() {}),
                  child: Text(
                    'forgot pasword?',
                    style: TextStyle(color: Colors.black54),
                  ))
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: 300,
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text('Login'),
                onPressed: () {
                  print('Login');
                }),
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            "or continue with",
            style: TextStyle(color: Colors.grey.shade400),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Row(
              children: [
                SignInButton(
                  Buttons.Facebook,
                  mini: true,
                  shape: CircleBorder(side: BorderSide.none),
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.Apple,
                  shape: CircleBorder(side: BorderSide.none),
                  mini: true,
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.GitHub,
                  shape: CircleBorder(side: BorderSide.none),
                  mini: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _ishidden = !_ishidden;
    });
  }
}
