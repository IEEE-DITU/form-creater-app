import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/navigation/home_screen.dart';
import 'package:ieee_forms/navigation/nav_bar_screen.dart';
import 'package:ieee_forms/services/firebase_service.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.formId}) : super(key: key);
  final String formId;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  FirebaseService fire = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/Background.png'), fit: BoxFit.cover)),
        child: FutureBuilder(
            future: fire.getFormData(widget.formId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.formTitle),
                      TextButton(
                          onPressed: () async {
                            await fire.deleteForm(widget.formId);
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NavBarScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text('Delete'))
                    ],
                  ),
                );
              }
              return SizedBox();
            }),
      ),
    );
  }
}
