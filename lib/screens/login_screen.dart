import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/screens/loading_screen.dart';
import 'package:ieee_forms/screens/signup_screen.dart';
import 'package:ieee_forms/services/firebase_service.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  // bool _isCheck = false;
  FirebaseService fire = FirebaseService();
  String _email = "";
  String _password = "";
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
                  RichText(
                      text: TextSpan(
                          text: 'Register Here !',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()),
                                (Route<dynamic> route) => false,
                              );
                            })),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: " Enter your email address",
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //         value: _isCheck,
                      //         onChanged: (val) {
                      //           setState(() {
                      //             _isCheck = val!;
                      //           });
                      //         }),
                      //     const Text(
                      //       "Remember me",
                      //       style: TextStyle(fontSize: 13),
                      //     ),
                      //   ],
                      // ),
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
                          minimumSize: const Size.fromHeight(50)),
                      child: (isProcessing)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Login'),
                      onPressed: () async {
                        if (!isProcessing) {
                          setState(() {
                            isProcessing = true;
                          });
                          debugPrint('Login');
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password);
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoadingScreen()),
                                (Route<dynamic> route) => false,
                              );
                            } on FirebaseAuthException catch (e) {
                              debugPrint(e.code.toString());

                              if (e.code == 'user-not-found') {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBarUserNotFound);
                              } else if (e.code == 'wrong-password') {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBarLoginFailed);
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarInvalidCredentials);
                          }

                          setState(() {
                            isProcessing = false;
                          });
                        }
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
