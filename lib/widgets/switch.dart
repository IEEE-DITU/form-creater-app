import 'package:flutter/material.dart';
import 'package:ieee_forms/services/firebase_service.dart';

class FormSwitch extends StatefulWidget {
  const FormSwitch({required this.currentValue, required this.formId, Key? key})
      : super(key: key);
  final bool currentValue;
  final String formId;
  @override
  State<FormSwitch> createState() => _FormSwitchState();
}

class _FormSwitchState extends State<FormSwitch> {
  FirebaseService fire = FirebaseService();
  late bool currentValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentValue = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: currentValue,
      onChanged: (bool value) async {
        await fire.toggleAcceptingResponses(widget.formId, currentValue);
        setState(() {
          currentValue = value;
        });
      },
    );
  }
}
