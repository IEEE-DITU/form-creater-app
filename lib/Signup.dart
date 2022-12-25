import 'package:flutter/material.dart';
import 'package:ieee_forms/Signin.dart';

class MySignup extends StatefulWidget {
  const MySignup({super.key});

  @override
  State<MySignup> createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
   bool _ishidden = true;

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
              'Sign up',
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
            child: Text('Already have an account with us?',
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
                  Text(
                    'Skip to ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print('login');
                      Navigator.push(
                          context,
                          MaterialPageRoute( builder: (context) => const MySignin()));
                    },
                    child: Text('Login !',
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

          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: " Enter your User name ",
                labelText: "Username"),
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

          TextFormField(
            obscureText: _ishidden,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                 suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child:
                      Icon(_ishidden ? Icons.visibility : Icons.visibility_off),
                ),
                hintText: "Confirm your Password",
                labelText: "Confirmation Password"),
          ),

          SizedBox(
            height: 30.0,
          ),

          SizedBox(
            width: 300,
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text('Register'),
                onPressed: () {
                  print('Register');
                }),
          )
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
