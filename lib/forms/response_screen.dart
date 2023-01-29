import 'package:flutter/material.dart';
import 'package:ieee_forms/forms/individual_response_screen.dart';
import 'package:ieee_forms/forms/summary_response_screen.dart';
import 'package:ieee_forms/services/create_csv.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:ieee_forms/widgets/custom_scaffold.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';

class ResponseScreen extends StatelessWidget {
  const ResponseScreen({Key? key, required this.currentForm}) : super(key: key);
  final FormData currentForm;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        appBar: AppBar(
          title: Text(currentForm.formTitle),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Summary'),
              Tab(
                text: 'Individual',
              )
            ],
          ),
          actions: [
            IconButton(onPressed: () async {
              Export export = Export();
              bool success = await export.generateCSV(currentForm);
              //ignore:use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                  defaultSnackBar((success)?
                       'File saved successfully'
                      : 'Error!! Please try again later'));
            }, icon: const Icon(
              Icons.download
            ))
          ],
        ),
        child: TabBarView(
          children: [
            SummaryResponse(currentForm: currentForm,),
            IndividualResponseScreen(currentForm: currentForm,)
          ],
        ),
      ),
    );
  }
}
