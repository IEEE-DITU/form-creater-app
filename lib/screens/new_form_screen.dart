import 'package:flutter/material.dart';
import 'package:ieee_forms/services/firebase_service.dart';

class NewFormScreen extends StatefulWidget {
  const NewFormScreen({Key? key}) : super(key: key);

  @override
  State<NewFormScreen> createState() => _NewFormScreenState();
}

class _NewFormScreenState extends State<NewFormScreen> {
  FirebaseService fire = FirebaseService();
  String formTitle = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.email_outlined),
                  hintText: " Enter Form Title",
                  labelText: "Title"),
              onChanged: (value) {
                formTitle = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    minimumSize: const Size.fromHeight(50)),
                child: const Text('Add New Form'),
                onPressed: () async {
                  await fire.createNewForm(formTitle);
                })
          ],
        ),
      ),
    );
  }
}
