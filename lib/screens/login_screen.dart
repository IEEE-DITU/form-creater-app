import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isHidden = true;
  bool _isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(children: [
          const SizedBox(
            height: 100.0,
          ),
          const SizedBox(
            width: 500,
            child: Text(
              'Sign in',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const SizedBox(
            width: 500,
            child: Text(" Don't have an account yet?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
              width: 500,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    child: const Text('Register here !',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20)),
                  )
                ],
              )),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                hintText: " Enter your email address",
                labelText: "Email"),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            obscureText: _isHidden,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child:
                      Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
                ),
                hintText: " Enter your Password",
                labelText: "Password"),
          ),
          const SizedBox(
            height: 1.0,
          ),
          Row(
            children: [
              Checkbox(
                  value: _isCheck,
                  onChanged: (val) {
                    setState(() {
                      _isCheck = val!;
                    });
                  }),
              const Text(
                "Remember me",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                width: 40.0,
              ),
              TextButton(
                  onPressed: (() {}),
                  child: const Text(
                    'forgot pasword?',
                    style: TextStyle(color: Colors.black54),
                  ))
            ],
          ),
          const SizedBox(
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
                child: const Text('Login'),
                onPressed: () {
                  debugPrint('Login');
                }),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            "or continue with",
            style: TextStyle(color: Colors.grey.shade400),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Row(
              children: [
                SignInButton(
                  Buttons.Facebook,
                  mini: true,
                  shape: const CircleBorder(side: BorderSide.none),
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.Apple,
                  shape: const CircleBorder(side: BorderSide.none),
                  mini: true,
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.GitHub,
                  shape: const CircleBorder(side: BorderSide.none),
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
      _isHidden = !_isHidden;
    });
  }
}
