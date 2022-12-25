import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const SizedBox(
            height: 100.0,
          ),
          const SizedBox(
            width: 500,
            child: Text(
              'Sign up',
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
            child: Text('Already have an account with us?',
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
                  const Text(
                    'Skip to ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint('login');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Login !',
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
          SizedBox(
            width: 300,
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: const Text('Register'),
                onPressed: () {
                  debugPrint('Register');
                }),
          )
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
