import 'package:flutter/material.dart';
import 'package:ieee_forms/forms/form_screen.dart';
import 'package:ieee_forms/services/firebase_cloud.dart';

import '../widgets/custom_scaffold.dart';

class NewFormScreen extends StatefulWidget {
  const NewFormScreen({Key? key}) : super(key: key);

  @override
  State<NewFormScreen> createState() => _NewFormScreenState();
}

class _NewFormScreenState extends State<NewFormScreen> {
  //Disable button While processing
  int maxclick = 1;
  int counter = 1;
  FirebaseCloudService fireCloud = FirebaseCloudService();
  String formTitle = "";
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Create New Form'),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter Form Title', style: TextStyle(fontSize: 18),),
          TextFormField(
            decoration: const InputDecoration(

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
              onPressed: counter > maxclick
                  ? null
                  : () async {
                      String formID = await fireCloud.createNewForm(
                          formTitle, getCurrentDate(), '', '');
                      setState(() {
                        counter++;
                      });
                      //ignore:use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormScreen(formId: formID)));
                    },
              child: const Text('Add New Form'))
        ],
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
