import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text("Don't have an account yet?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 5.0,
              ),
              RichText(text: TextSpan(
                text: 'Register Here !',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                          (Route<dynamic> route) => false,);
                  }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    ],
                  ),
                  TextButton(
                      onPressed: (() {}),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.black54),
                      ))
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    minimumSize: const Size.fromHeight(50)
                  ),
                  child: const Text('Login'),
                  onPressed: () {
                    debugPrint('Login');
                  }),
            ]),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
