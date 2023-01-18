import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ieee_forms/services/colors.dart';

Future<void> customDialog(BuildContext context, String title, Widget content,
    AsyncCallback function) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: CustomColors.disabledColor),
                )),
            TextButton(
                onPressed: () {
                  function();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: CustomColors.primaryColor),
                )),
          ],
        );
      });
}
