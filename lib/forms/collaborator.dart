import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ieee_forms/services/firebase_cloud.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:ieee_forms/services/user.dart';
import 'package:ieee_forms/widgets/custom_dialog.dart';
import 'package:ieee_forms/widgets/custom_scaffold.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';

class CollaboratorScreen extends StatefulWidget {
  const CollaboratorScreen({Key? key}) : super(key: key);

  @override
  State<CollaboratorScreen> createState() => _CollaboratorScreenState();
}

class _CollaboratorScreenState extends State<CollaboratorScreen> {
  FirebaseCloudService fireCloud = FirebaseCloudService();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        key: GlobalKey(),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Form Collaborators'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            String email = "";
            bool isEnabled = false;
            customDialog(
                context,
                'Add New Collaborator',
                TextFormField(
                  initialValue: email,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (EmailValidator.validate(email)) {
                      isEnabled = true;
                      return null;
                    }
                    isEnabled = false;
                    return 'Enter Valid email';
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ), () async {
              if (isEnabled) {
                addCollaborator(email);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBarInvalidCredentials);
              }
            });
          },
          label: const Text('Add New'),
          icon: const Icon(Icons.person_add_alt_outlined),
        ),
        child: (FormData.currentForm.collaborators.isEmpty)
            ? const Center(
                child: Text('You haven\'t added any collaborator yet!'),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 100.0 * FormData.currentForm.collaborators.length,
                    child: ListView.builder(
                        key: GlobalKey(),
                        itemCount: FormData.currentForm.collaborators.length,
                        itemBuilder: (context, index) {
                          String email =
                              FormData.currentForm.collaborators[index];
                          return Container(
                            key: GlobalKey(),
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Slidable(
                                      key: GlobalKey(),
                                      endActionPane: ActionPane(
                                        extentRatio: 0.25,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            flex: 1,
                                            onPressed: (ctx) async {
                                              customDialog(
                                                  context,
                                                  'Confirm Delete',
                                                  Text(
                                                      'Do you really want to delete $email as collaborator ?'),
                                                  () async {
                                                FormData
                                                    .currentForm.collaborators
                                                    .remove(email);
                                                await fireCloud
                                                    .updateCurrentForm(
                                                        FormData.currentForm);
                                              }).then(
                                                  (value) => setState(() {}));
                                            },
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                    right: Radius.circular(8)),
                                          )
                                        ],
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(8)),
                                            color: Colors.white),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Collaborator ${index + 1}',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(email),
                                            ]),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ));
  }

  Future<void> addCollaborator(String email) async {
    if (FormData.currentForm.collaborators.contains(email)) {
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar('Failure !',
          'Email already added to collaborators', ContentType.failure));
    } else if (!(await fireCloud.checkEmailExists(email))) {
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          'Failure !', 'Email does not exists', ContentType.failure));
    } else if (email != MyUser.currentUser.email) {
      FormData.currentForm.collaborators.add(email);
      await fireCloud.updateCurrentForm(FormData.currentForm);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar('Failure !',
          'Cannot add your own email to collaborators', ContentType.failure));
    }
    setState(() {});
  }
}
