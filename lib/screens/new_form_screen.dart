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
                  await fire.createNewForm(formTitle, getCurrentDate());
                })
          ],
        ),
      ),
    );
  }

  String getCurrentDate() {
    int date = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    int hour = DateTime.now().hour;
    int min = DateTime.now().minute;
    int second = DateTime.now().second;
    String mon = "";
    switch (month) {
      case 1:
        mon = "Jan";
        break;
      case 2:
        mon = "Feb";
        break;
      case 3:
        mon = "Mar";
        break;
      case 4:
        mon = "Apr";
        break;
      case 5:
        mon = "May";
        break;
      case 6:
        mon = "Jun";
        break;
      case 7:
        mon = "Jul";
        break;
      case 8:
        mon = "Aug";
        break;
      case 9:
        mon = "Sep";
        break;
      case 10:
        mon = "Oct";
        break;
      case 11:
        mon = "Nov";
        break;
      case 12:
        mon = "Dec";
        break;
    }
    String timeStamp = '$date $mon $year $hour:$min:$second';
    return (timeStamp);
  }
}
