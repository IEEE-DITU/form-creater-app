import 'package:flutter/material.dart';
import 'package:ieee_forms/navigation/nav_bar_screen.dart';
import 'package:ieee_forms/services/firebase_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ieee_forms/widgets/question_widgets.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';
import '../services/form_data.dart';

FirebaseService fire = FirebaseService();

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.formId}) : super(key: key);
  final String formId;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool isLoading = true;

  @override
  void initState() {
    getCurrentFormData();
    super.initState();
  }

  void getCurrentFormData() async {
    FormData.currentForm = await fire.getFormData(widget.formId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const CircularProgressIndicator()
        : GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 70,
                  title: TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return 'Title cannot be null';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      FormData.currentForm.formTitle = value;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: FormData.currentForm.formTitle,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                floatingActionButton: SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.4,
                  spaceBetweenChildren: 8,
                  spacing: 8,
                  children: [
                    SpeedDialChild(
                        child: const Icon(Icons.delete),
                        label: 'Delete Form',
                        onTap: () async {
                          await fire.deleteForm(widget.formId);
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavBarScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }),
                    SpeedDialChild(
                        child: const Icon(Icons.share),
                        label: 'Share Link',
                        onTap: () {}),
                    SpeedDialChild(
                        child: const Icon(Icons.save),
                        label: 'Save Progress',
                        onTap: () async {
                          await fire.updateCurrentForm(FormData.currentForm);
                          //ignore:use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarSavedSuccessfully);
                        })
                  ],
                ),
                body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Assets/Background.png'),
                          fit: BoxFit.cover)),
                  child: ListView.builder(
                    itemCount: FormData.currentForm.questions.length,
                      itemBuilder: (context, index) {
                      debugPrint(FormData.currentForm.questions[index].toString());
                      return TextTypeQuestion(index: index);
                      }),
                )),
          );
  }
}
