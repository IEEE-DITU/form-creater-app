import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text('Already have an account with us?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Skip to ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                        )
                      ),
                      TextSpan(
                        text: 'Login !',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint('login');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                  (Route<dynamic> route) => false,);
                          }
                      )
                    ]
                  )),
              const SizedBox(
                height: 30.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "Enter your email address",
                    labelText: "Email"),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: " Enter your User name ",
                    labelText: "Username"),
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
              TextFormField(
                obscureText: _isHidden,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child:
                          Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
                    ),
                    hintText: "Confirm your Password",
                    labelText: "Confirmation Password"),
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
                  child: const Text('Register'),
                  onPressed: () {
                    debugPrint('Register');
                  })
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
