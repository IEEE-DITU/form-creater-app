import 'package:flutter/services.dart';
import 'package:ieee_forms/forms/form_screen.dart';
import 'package:ieee_forms/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/user.dart';

import '../widgets/snack_bar.dart';
import '../widgets/switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseService fire = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My forms'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/Background.png'), fit: BoxFit.cover)),
        child: FutureBuilder(
            future: MyUser.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: MyUser.currentUser.forms.length,
                    itemBuilder: (context, index) {
                      String formId = MyUser.currentUser.forms[index];
                      return FutureBuilder(
                          future: fire.getFormData(formId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); //Container
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              bool accRes = snapshot.data!.acceptingResponses;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FormScreen(formId: formId)));
                                },
                                child: Container(
                                  height: 150,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Form Title: ${snapshot.data!.formTitle}'),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Creation Date:  ${snapshot.data!.createdAt}'),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                  'Number of Responses: 0'),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                  child: TextButton(
                                                child: const Text(
                                                    'View Responses'),
                                                onPressed: () {},
                                              ))
                                            ],
                                          )),
                                      Column(
                                        children: [
                                          Expanded(
                                            child: FormSwitch(
                                              formId: formId,
                                              initialValue: accRes,
                                              function: 'toggleResponse',
                                            ),
                                          ),
                                          Expanded(
                                              child: TextButton(
                                                  onPressed: () async {
                                                    await Clipboard.setData(
                                                        ClipboardData(
                                                            text:
                                                                'https://form-website-seven.vercel.app/form/$formId'));
                                                    //ignore:use_build_context_synchronously
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            snackBarLinkCopied);
                                                  },
                                                  child: const Text(
                                                      'Get form link')))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const SizedBox(
                              height: 10,
                            );
                          });
                    });
              }
            }),
      ),
    );
  }
}
