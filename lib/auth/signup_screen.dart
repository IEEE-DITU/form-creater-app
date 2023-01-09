import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ieee_forms/auth/loading_screen.dart';
import 'package:ieee_forms/services/firebase_service.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  FirebaseService fire = FirebaseService();
  bool isProcessing = false;

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
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text('Already have an account with us?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: 'Skip to ',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    TextSpan(
                        text: 'Login !',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (Route<dynamic> route) => false,
                            );
                          })
                  ])),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Enter your email address",
                        labelText: "Email"),
                    onChanged: (value) {
                      _email = value;
                    },
                    validator: (value) {
                      if (!EmailValidator.validate(_email)) {
                        return 'Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: " Enter your User name ",
                        labelText: "Username"),
                    onChanged: (value) {
                      _username = value;
                    },
                    validator: (value) {
                      if (_username.length < 4) {
                        return 'Username should be atleast 4 letters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(_isHidden
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: " Enter your Password",
                        labelText: "Password"),
                    onChanged: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (_password.length < 6) {
                        return 'Password should be atleast 4 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(_isHidden
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: "Confirm your Password",
                        labelText: "Confirmation Password"),
                    onChanged: (value) {
                      _confirmPassword = value;
                    },
                    validator: (value) {
                      if (_password != _confirmPassword) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          minimumSize: const Size.fromHeight(50)),
                      child: (isProcessing)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Register'),
                      onPressed: () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        if (!isProcessing) {
                          setState(() {
                            isProcessing = true;
                          });
                          debugPrint('Register');
                          if (_formKey.currentState!.validate()) {
                            bool isSuccess = await fire.signupNewUser(
                                _email, _password, _username);
                            if (isSuccess) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoadingScreen()),
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarSignupUnsuccessful);
                            }
                          }
                          setState(() {
                            isProcessing = false;
                          });
                        }
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
