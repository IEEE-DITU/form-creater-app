import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/user.dart';

import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent[50],
        body: Center(
          child: Container(
              padding: const EdgeInsetsDirectional.all(7.0),
              child: Column(
                children: [
                  Stack(children: [
                    SizedBox(
                      width: 200,
                      height: 250,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: AssetImage("assets/avatar 2.png"),
                          )),
                    ),
                    Positioned(
                      bottom: 60,
                      right: 50,
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.account_circle_rounded,
                          )),
                    ),
                  ]),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Name:Amisha Tandon",
                        style: TextStyle(fontSize: 20),
                      )),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Email Id:abcd@gmail.com",
                        style: TextStyle(fontSize: 20),
                      )),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Forms Created:23",
                        style: TextStyle(fontSize: 20),
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        child: Text(
                          "report a problem?",
                        ),
                        onPressed: () {},
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          minimumSize: const Size.fromHeight(50)),
                      child: const Text('Logout'),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }),
                  Expanded(
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                            width: 200,
                            height: 250,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image(
                                  image: AssetImage(
                                      "assets/Allura Giant Phone.png"),
                                )))),
                  ),
                ],
              )),
        ));
  }
}
