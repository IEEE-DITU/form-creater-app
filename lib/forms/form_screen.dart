import 'package:flutter/material.dart';
import 'package:ieee_forms/navigation/nav_bar_screen.dart';
import 'package:ieee_forms/services/firebase_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ieee_forms/services/questions.dart';
import 'package:ieee_forms/widgets/question_widgets.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';
import 'package:ieee_forms/widgets/switch.dart';
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
                resizeToAvoidBottomInset: false,
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
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: FormData.currentForm.questions.length,
                            itemBuilder: (context, index) {
                              final currentQuestion =
                                  FormData.currentForm.questions[index];
                              String questionType =
                                  currentQuestion['questionType'];
                              return Column(
                                children: [
                                  Container(
                                    key: GlobalKey(),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    prefix:
                                                        Text('${index + 1}.  '),
                                                    border: InputBorder.none,
                                                    errorStyle: const TextStyle(
                                                        color: Colors.red)),
                                                initialValue: currentQuestion[
                                                    'questionTitle'],
                                                onChanged: (val) {
                                                  currentQuestion[
                                                      'questionTitle'] = val;
                                                },
                                                validator: (val) {
                                                  if (val == '') {
                                                    return 'Question Title cannot be empty';
                                                  }
                                                  return null;
                                                },
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      FormData
                                                          .currentForm.questions
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        (questionType == 'text')
                                            ? TextTypeQuestion(index: index)
                                            : (questionType == 'singleChoice')
                                                ? ChoiceTypeQuestion(
                                                    index: index,
                                                    type: 'single')
                                                : ChoiceTypeQuestion(
                                                    index: index,
                                                    type: 'multiple'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text('Required'),
                                                FormSwitch(
                                                    initialValue:
                                                        currentQuestion[
                                                            'isRequired'],
                                                    questionIndex: index,
                                                    function: 'isRequired'),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .50,
                                              child: DropdownButtonFormField(
                                                  value: questionType,
                                                  items: const [
                                                    DropdownMenuItem(
                                                        value: 'text',
                                                        child: Text('Text')),
                                                    DropdownMenuItem(
                                                        value: 'singleChoice',
                                                        child: Text(
                                                            'Single Choice')),
                                                    DropdownMenuItem(
                                                        value: 'multipleChoice',
                                                        child: Text(
                                                            'Multiple Choice'))
                                                  ],
                                                  onChanged: (value) {
                                                    currentQuestion[
                                                        'questionType'] = value;
                                                    setState(() {
                                                      questionType = value!;
                                                    });
                                                  }),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  (index ==
                                          FormData.currentForm.questions
                                                  .length -
                                              1)
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 20,
                                              bottom: 50,
                                              left: 16,
                                              right: 16),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  minimumSize:
                                                      const Size.fromHeight(
                                                          50)),
                                              child: const Text(
                                                  'Add new Questions'),
                                              onPressed: () {
                                                FormQuestions questions =
                                                    FormQuestions();
                                                setState(() {
                                                  FormData.currentForm.questions
                                                      .add(questions
                                                          .defaultTextTypeQuestion);
                                                });
                                              }),
                                        )
                                      : const SizedBox(),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                )),
          );
  }
}
