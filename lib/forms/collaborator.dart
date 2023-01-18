import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:ieee_forms/widgets/scaffold_widget.dart';

class CollaboratorScreen extends StatefulWidget {
  const CollaboratorScreen({Key? key}) : super(key: key);

  @override
  State<CollaboratorScreen> createState() => _CollaboratorScreenState();
}

class _CollaboratorScreenState extends State<CollaboratorScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Form Collaborators'),
        ),

        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: FormData.currentForm.collaborators.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Slidable(
                                key: GlobalKey(),
                                endActionPane: ActionPane(
                                  dismissible: DismissiblePane(onDismissed: () {}),
                                  extentRatio: 0.25,
                                  motion: const ScrollMotion(),
                                  children: const [
                                    SlidableAction(
                                      flex: 1,
                                      onPressed: null,
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                                    )
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                                      color: Colors.white),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Collaborator ${index + 1}', style:
                                        const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                        ),),
                                      const SizedBox(height: 10,),
                                      Text(
                                      FormData.currentForm.collaborators[index]
                                    ),]
                                  ),
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
}
