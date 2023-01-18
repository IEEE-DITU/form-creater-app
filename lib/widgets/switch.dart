
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/firebase_cloud.dart';

import '../services/form_data.dart';

class FormSwitch extends StatefulWidget {
  const FormSwitch({required this.initialValue, this.formId, Key? key, required this.function, this.questionIndex})
      : super(key: key);
  final bool initialValue;
  final String? formId;
  final int? questionIndex;
  final String function;
  @override
  State<FormSwitch> createState() => _FormSwitchState();
}

class _FormSwitchState extends State<FormSwitch> {
  FirebaseCloudService fireCloud = FirebaseCloudService();
  late bool currentValue;
  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: currentValue,
      onChanged: (bool value) async {
        if(widget.function == 'toggleResponse') {
          await fireCloud.toggleAcceptingResponses(widget.formId!, currentValue);
        } else if(widget.function == 'isRequired') {
          FormData.currentForm.questions[widget.questionIndex!]['isRequired'] = value;
        }
        setState(() {
          currentValue = value;
        });
      },
    );
  }
}
