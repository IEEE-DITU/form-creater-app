import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ieee_forms/forms/collaborator.dart';
import 'package:ieee_forms/navigation/nav_bar_screen.dart';
import 'package:ieee_forms/services/firebase_cloud.dart';
import 'package:ieee_forms/services/questions.dart';
import 'package:ieee_forms/widgets/custom_button.dart';
import 'package:ieee_forms/widgets/custom_dialog.dart';
import 'package:ieee_forms/widgets/custom_scaffold.dart';
import 'package:ieee_forms/widgets/question_widgets.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';
import 'package:ieee_forms/widgets/switch.dart';

import '../services/form_data.dart';

FirebaseCloudService fireCloud = FirebaseCloudService();

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
    FormData.currentForm = await fireCloud.getFormData(widget.formId);
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
            child: CustomScaffold(
                resize: true,
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
                          customDialog(
                              context,
                              'Delete Form',
                              const Text(
                                  'All responses will be deleted along with the form data'),
                              () async {
                            await fireCloud.deleteForm(widget.formId);
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NavBarScreen()),
                              (Route<dynamic> route) => false,
                            );
                          });
                        }),
                    SpeedDialChild(
                        child: const Icon(Icons.share),
                        label: 'Share Link',
                        onTap: () async {
                          qrDialog(context);
                        }),
                    SpeedDialChild(
                        child: const Icon(Icons.save),
                        label: 'Save Progress',
                        onTap: () async {
                          customDialog(context, 'Save',
                              const Text('Do you want to save changes?'),
                              () async {
                            await fireCloud
                                .updateCurrentForm(FormData.currentForm);
                            //ignore:use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarSavedSuccessfully);
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NavBarScreen()),
                              (Route<dynamic> route) => false,
                            );
                          });
                        }),
                    SpeedDialChild(
                        child: const Icon(Icons.person_add_alt_1_outlined),
                        label: 'Collaborators',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CollaboratorScreen()));
                        })
                  ],
                ),
                child: ListView(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                FormData.currentForm.questions
                                                    .removeAt(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.close_outlined,
                                              color: Colors.red,
                                            )),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          prefix: Text('${index + 1}.  '),
                                          border: InputBorder.none,
                                          errorStyle: const TextStyle(
                                              color: Colors.red)),
                                      initialValue:
                                          currentQuestion['questionTitle'],
                                      onChanged: (val) {
                                        currentQuestion['questionTitle'] =
                                            val;
                                      },
                                      validator: (val) {
                                        if (val == '') {
                                          return 'Question Title cannot be empty';
                                        }
                                        return null;
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    (questionType == 'attachment')
                                        ? AttachmentTypeQuestion(
                                            index: index,
                                          )
                                        : (questionType == 'text')
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
                                                initialValue: currentQuestion[
                                                    'isRequired'],
                                                questionIndex: index,
                                                function: 'isRequired'),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
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
                                                        'Multiple Choice')),
                                                DropdownMenuItem(
                                                    value: 'attachment',
                                                    child: Text('Attachment'))
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
                            ],
                          );
                        }),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2),
                      child: customButton(context, 'Add New Question', () {
                        FormQuestions questions = FormQuestions();
                        setState(() {
                          FormData.currentForm.questions
                              .add(questions.defaultTextTypeQuestion);
                        });
                      }),
                    )
                  ],
                )),
          );
  }
}
