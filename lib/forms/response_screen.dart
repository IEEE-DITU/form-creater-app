import 'package:flutter/material.dart';
import 'package:ieee_forms/forms/summary_response.dart';
import 'package:ieee_forms/services/form_data.dart';
import 'package:ieee_forms/widgets/custom_scaffold.dart';

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
        ),
        child: TabBarView(
          children: [
            SummaryResponse(currentForm: currentForm,),
            Container(
              color: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
