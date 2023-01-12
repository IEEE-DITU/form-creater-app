import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/user.dart';

import '../auth/login_screen.dart';
import '../widgets/scaffold_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              children: [
                Stack(children: [
                  SizedBox(
                    width: 200,
                    height: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage("Assets/Avatar_img.png"),
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
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Name: ${MyUser.currentUser.name}",
                      style: const TextStyle(fontSize: 20),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email Id: ${MyUser.currentUser.email}",
                      style: const TextStyle(fontSize: 20),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Forms Created: ${MyUser.currentUser.forms.length}",
                      style: const TextStyle(fontSize: 20),
                    )),
                Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: const Text(
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
                              child: const Image(
                                image: AssetImage("Assets/Profile_footer.png"),
                              )))),
                ),
              ],
            )));
  }
}
