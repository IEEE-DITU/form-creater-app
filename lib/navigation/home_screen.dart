import 'package:flutter/services.dart';
import 'package:ieee_forms/forms/form_screen.dart';
import 'package:ieee_forms/forms/response_screen.dart';
import 'package:ieee_forms/navigation/my_screen.dart';
import 'package:ieee_forms/navigation/new_form_screen.dart';
import 'package:ieee_forms/services/firebase_cloud.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/user.dart';

import '../widgets/custom_scaffold.dart';
import '../widgets/snack_bar.dart';
import '../widgets/switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseCloudService fireCloud = FirebaseCloudService();
  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    await MyUser.getCurrentUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('My forms'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
          }, icon: Image.network(MyUser.currentUser.profileImg))
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 200,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewFormScreen()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Create New Form'),
              Icon(Icons.create_outlined)
            ],
          ),
        ),
      ),
      child: (isLoading)
          ? const CircularProgressIndicator()
          : RefreshIndicator(
              onRefresh: () {
                return getData();
              },
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: MyUser.currentUser.forms.length,
                  itemBuilder: (context, index) {
                    String formId = MyUser.currentUser.forms[index];
                    return FutureBuilder(
                        future: fireCloud.getFormData(formId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); //Container
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            bool accRes = snapshot.data!.acceptingResponses;
                            return GestureDetector(
                              key: GlobalKey(),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormScreen(formId: formId)));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                            Text(
                                                'Number of Responses: ${snapshot.data!.allResponses.length}'),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Expanded(
                                                child: TextButton(
                                              child:
                                                  const Text('View Responses'),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ResponseScreen(
                                                                currentForm:
                                                                    snapshot
                                                                        .data!)));
                                              },
                                            ))
                                          ],
                                        )),
                                    Expanded(
                                      child: FormSwitch(
                                        formId: formId,
                                        initialValue: accRes,
                                        function: 'toggleResponse',
                                      ),
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
                  }),
            ),
    );
  }
}
